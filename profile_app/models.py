from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone # For default update_time, though auto_now handles it
from django.db.models.signals import post_save
from django.dispatch import receiver
import uuid # 导入 uuid 模块
import datetime # Import datetime for year
from django.db.models import Max # Import Max for sequence generation

# User Profile Model
class UserProfile(models.Model):
    ROLE_STUDENT = 'student'
    ROLE_ADMIN = 'admin'
    # Add other roles as constants if they exist in ROLE_CHOICES

    GENDER_CHOICES = [
        ('male', '男'),
        ('female', '女'),
    ]
    ROLE_CHOICES = [
        (ROLE_STUDENT, '学生'),
        (ROLE_ADMIN, '管理员'),
        # Ensure all roles used in the application are defined here and as constants above
    ]

    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='userprofile', verbose_name='用户')
    name = models.CharField(max_length=100, verbose_name='姓名', help_text='用户的真实姓名或常用名')
    student_id = models.CharField(
        max_length=50, 
        unique=True, 
        null=True, 
        blank=True, 
        verbose_name='学号',
        help_text='学生的学号。对于学生角色，系统通常会自动生成；对于其他角色，此字段可选。'
    )
    gender = models.CharField(max_length=10, choices=GENDER_CHOICES, default='unknown', verbose_name='性别')
    role = models.CharField(max_length=10, choices=ROLE_CHOICES, default=ROLE_STUDENT, verbose_name='角色') # Default to student
    bio = models.TextField(blank=True, verbose_name='简介')

    def __str__(self):
        return f"{self.name or self.user.username} ({self.get_role_display()})"

    class Meta:
        verbose_name = '用户资料'
        verbose_name_plural = '用户资料'

# Student Record Model
class StudentRecord(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='student_records', verbose_name='关联用户')
    
    # Core learning metrics from original model
    homework_score = models.FloatField(verbose_name='作业得分') # Assuming 0-100 scale
    training_pass_rate = models.FloatField(verbose_name='实训通过率') # Percentage 0-100
    test_completion_rate = models.FloatField(verbose_name='测验完成率') # Percentage 0-100
    sign_in_score = models.FloatField(verbose_name='签到得分') # Could be rate or points
    homework_completion_rate = models.FloatField(verbose_name='作业按时完成率') # Percentage 0-100
    video_watch_rate = models.FloatField(verbose_name='视频观看率') # Percentage 0-100
    test_completion_count = models.IntegerField(verbose_name='测验完成次数')
    homework_completion_count = models.IntegerField(verbose_name='作业完成次数')
    course_interaction_score = models.FloatField(verbose_name='课程互动得分') # Quantitative score

    create_time = models.DateTimeField(auto_now_add=True, verbose_name='创建时间')
    update_time = models.DateTimeField(auto_now=True, verbose_name='更新时间') # Added update_time

    def __str__(self):
        return f"学习记录 for {self.user.userprofile.name if hasattr(self.user, 'userprofile') else self.user.username} at {self.create_time.strftime('%Y-%m-%d %H:%M')}"

    class Meta:
        verbose_name = '学生学习记录'
        verbose_name_plural = '学生学习记录'
        ordering = ['-create_time']

# Cluster Result Model
class ClusterResult(models.Model):
    student_record = models.OneToOneField(StudentRecord, on_delete=models.CASCADE, verbose_name='关联学生记录', related_name='cluster_result') # Changed from ForeignKey for 1-to-1 if a record has one result
    knowledge_dimension_score = models.FloatField(verbose_name='知识维度得分')
    attitude_dimension_score = models.FloatField(verbose_name='学习态度维度得分')
    interest_dimension_score = models.FloatField(verbose_name='课程兴趣维度得分')
    final_score = models.FloatField(verbose_name='综合得分')
    rating = models.CharField(max_length=20, default="中等", verbose_name='综合评级') # Increased max_length slightly
    cluster_id = models.IntegerField(verbose_name='簇ID', null=True, blank=True, help_text='模型分配的簇标签') # Added cluster_id as per DB schema
    
    create_time = models.DateTimeField(auto_now_add=True, verbose_name='创建时间') # Renamed from created_at
    update_time = models.DateTimeField(auto_now=True, verbose_name='更新时间') # Renamed from updated_at
    
    class Meta:
        verbose_name = '聚类分析结果'
        verbose_name_plural = '聚类分析结果'
        ordering = ['-final_score', '-create_time']

    def __str__(self):
        return f"聚类结果 for {self.student_record.user.userprofile.name if hasattr(self.student_record.user, 'userprofile') else self.student_record.user.username} - 得分: {self.final_score:.2f}"

# Model Log Model
class ModelLog(models.Model):
    train_time = models.DateTimeField(auto_now_add=True, verbose_name='训练时间')
    model_type = models.CharField(max_length=100, verbose_name='模型类型', default='KMeans')
    parameters = models.JSONField(null=True, blank=True, verbose_name='模型参数')
    performance_metrics = models.JSONField(null=True, blank=True, verbose_name='性能指标')
    notes = models.TextField(blank=True, null=True, verbose_name='备注')
    # Removed: sample_count, total_sse, silhouette_score as they can be in performance_metrics

    class Meta:
        verbose_name = '模型训练日志'
        verbose_name_plural = '模型训练日志'
        ordering = ['-train_time']

    def __str__(self):
        return f"{self.model_type} 模型训练于 {self.train_time.strftime('%Y-%m-%d %H:%M')}"

# Signal to create/update UserProfile when User is created/updated
@receiver(post_save, sender=User)
def create_or_update_user_profile(sender, instance, created, **kwargs):
    profile, new_profile_created = UserProfile.objects.get_or_create(user=instance)
    
    fields_modified = False

    # Role assignment logic
    if new_profile_created: # A UserProfile was just created by get_or_create
        # Its role would have been set to UserProfile.ROLE_STUDENT by model default.
        # We need to check if this user is staff/superuser and override role if necessary.
        if instance.is_staff or instance.is_superuser:
            if profile.role != UserProfile.ROLE_ADMIN: # If it defaulted to student or was somehow else
                profile.role = UserProfile.ROLE_ADMIN
                fields_modified = True
        # else: for non-staff/superuser, the default ROLE_STUDENT is correct. No change needed from default.
    
    # Name handling:
    name_from_user_model = instance.first_name or instance.last_name # Prefer actual name fields
    
    if new_profile_created and profile.name and profile.name != instance.username:
        # Profile was just created, and StudentRegistrationForm likely set its name.
        # If this name is different from username, trust the form's input.
        # No change needed here for profile.name if it was set by the form,
        # unless name_from_user_model provides a more specific value (first/last name).
        if name_from_user_model and profile.name != name_from_user_model:
            profile.name = name_from_user_model
            fields_modified = True
        # else, the name set by StudentRegistrationForm is kept.
    elif name_from_user_model and profile.name != name_from_user_model:
        # UserProfile existed, or was newly created but form didn't set a distinct name,
        # and User model has a specific first/last name.
        profile.name = name_from_user_model
        fields_modified = True
    elif not profile.name or profile.name == instance.username: 
        # Profile.name is empty, or currently same as username.
        # Try to improve it with first_name/last_name if available and different.
        # Otherwise, if all else fails and name is still empty, fallback to username.
        best_available_name = name_from_user_model or instance.username
        if profile.name != best_available_name:
            profile.name = best_available_name
            fields_modified = True

    # Auto-generate student_id for students with the new rule
    if profile.role == UserProfile.ROLE_STUDENT: # This check is now more reliable due to corrected role above
        if not profile.student_id:
            current_year = datetime.date.today().year
            year_prefix = str(current_year)
            
            last_student_profile_for_year = UserProfile.objects.filter(
                student_id__startswith=year_prefix
            ).order_by('-student_id').first()

            sequence_num = 1
            if last_student_profile_for_year and last_student_profile_for_year.student_id:
                try:
                    if len(last_student_profile_for_year.student_id) == 9 and last_student_profile_for_year.student_id.startswith(year_prefix):
                        sequence_num = int(last_student_profile_for_year.student_id[4:]) + 1
                except ValueError:
                    pass 
            
            profile.student_id = f"{year_prefix}{sequence_num:05d}"
            fields_modified = True

    if new_profile_created or fields_modified:
        profile.save()

# ... (rest of the file, StudentRecord, ModelLog, ClusterResult etc.) 