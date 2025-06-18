from django import forms
from django.contrib.auth.forms import UserCreationForm, AuthenticationForm
from django.contrib.auth.models import User
from .models import StudentRecord, UserProfile
from django.db import transaction
from dal import autocomplete

class UserModelChoiceField(forms.ModelChoiceField):
    def label_from_instance(self, obj):
        # obj here is a User instance
        name = obj.userprofile.name if hasattr(obj, 'userprofile') and obj.userprofile.name else obj.username
        student_id_str = f" (学号: {obj.userprofile.student_id})" if hasattr(obj, 'userprofile') and obj.userprofile.student_id else ""
        
        # 检查该学生用户是否还没有任何 StudentRecord 记录
        # student_records 是 User模型反向关联到 StudentRecord 的 related_name (在 StudentRecord.user 定义)
        has_records = False # Default to false
        if hasattr(obj, 'student_records'): # Check if related manager exists
            try:
                has_records = obj.student_records.exists()
            except Exception: # Catch any potential exception if related manager is not properly configured or accessible
                pass # Keep has_records as False

        pending_marker = "[待录入数据] " if not has_records else ""
        
        return f"{pending_marker}{name} ({obj.username}){student_id_str}"

class StudentRecordForm(forms.ModelForm):
    # 直接使用 UserModelChoiceField 并传入所有参数
    user = UserModelChoiceField( 
        queryset=User.objects.filter(userprofile__role='student').select_related('userprofile'),
        label="关联学生用户",
        help_text="请输入学生的用户名、姓名或学号搜索。",
        widget=autocomplete.ModelSelect2(url='profile_app:user-student-autocomplete', attrs={
            'data-placeholder': '输入姓名、用户名或学号进行搜索...',
            'data-minimum-input-length': 1,  # 最少输入1个字符开始搜索
            'data-html': True,  # 允许结果中使用HTML
            'class': 'form-control select2-autocomplete'  # 添加Bootstrap和自定义类
        })
    )

    # 定义百分比字段，在表单处理时转换
    training_pass_rate_percent = forms.IntegerField(
        min_value=0, max_value=100, 
        label="实训通过率",
        widget=forms.NumberInput(attrs={'class': 'form-control', 'step': '1'})
    )
    
    test_completion_rate_percent = forms.IntegerField(
        min_value=0, max_value=100, 
        label="测验完成率",
        widget=forms.NumberInput(attrs={'class': 'form-control', 'step': '1'})
    )
    
    homework_completion_rate_percent = forms.IntegerField(
        min_value=0, max_value=100, 
        label="作业完成率",
        widget=forms.NumberInput(attrs={'class': 'form-control', 'step': '1'})
    )
    
    video_watch_rate_percent = forms.IntegerField(
        min_value=0, max_value=100, 
        label="视频观看率",
        widget=forms.NumberInput(attrs={'class': 'form-control', 'step': '1'})
    )

    class Meta:
        model = StudentRecord
        fields = [
            'user', 
            'homework_score', 
            'training_pass_rate_percent',  # 替换 training_pass_rate
            'test_completion_rate_percent',  # 替换 test_completion_rate
            'sign_in_score', 
            'homework_completion_rate_percent',  # 替换 homework_completion_rate
            'video_watch_rate_percent',  # 替换 video_watch_rate
            'test_completion_count', 
            'homework_completion_count', 
            'course_interaction_score'
        ]
        exclude = [
            'training_pass_rate',
            'test_completion_rate',
            'homework_completion_rate',
            'video_watch_rate'
        ]
        
    def __init__(self, *args, **kwargs):
        instance = kwargs.get('instance')
        initial = kwargs.get('initial', {})
        
        # 如果是编辑现有记录，将小数比率转换为百分比整数
        if instance:
            # 处理百分比字段
            initial['training_pass_rate_percent'] = int(instance.training_pass_rate * 100)
            initial['test_completion_rate_percent'] = int(instance.test_completion_rate * 100)
            initial['homework_completion_rate_percent'] = int(instance.homework_completion_rate * 100)
            initial['video_watch_rate_percent'] = int(instance.video_watch_rate * 100)
            
            # 处理分数字段，格式化为一位小数
            initial['homework_score'] = round(instance.homework_score, 1)
            initial['sign_in_score'] = round(instance.sign_in_score, 1)
            initial['course_interaction_score'] = round(instance.course_interaction_score, 1)
            
            kwargs['initial'] = initial
            
        super().__init__(*args, **kwargs)
        
        # 确保用户字段的查询集是最新的
        self.fields['user'].queryset = User.objects.filter(userprofile__role='student').select_related('userprofile').order_by('userprofile__name', 'username')
        
        # 配置分数字段
        score_fields = {
            'homework_score': '作业成绩',
            'sign_in_score': '签到分数',
            'course_interaction_score': '课程互动分数'
        }
        
        # 配置计数器字段
        counter_fields = {
            'test_completion_count': {'max': 10, 'unit': '次'},  # 最大10次测验
            'homework_completion_count': {'max': 20, 'unit': '次'}  # 最大20次作业
        }
        
        # 配置比率字段标签
        rate_fields = {
            'training_pass_rate_percent': '实训通过率',
            'test_completion_rate_percent': '测验完成率',
            'homework_completion_rate_percent': '作业完成率',
            'video_watch_rate_percent': '视频观看率'
        }

        # 配置分数型字段
        for field_name, label in score_fields.items():
            if field_name in self.fields:
                self.fields[field_name].widget = forms.NumberInput(attrs={
                    'class': 'form-control score-input',
                    'min': '0',
                    'max': '100',
                    'step': '0.1',
                    'data-type': 'score',
                    'inputmode': 'decimal',
                    'style': 'text-align: left;' # 确保左对齐
                })
                self.fields[field_name].label = f"{label} (0-100分)"
                
        # 配置计数器字段
        for field_name, info in counter_fields.items():
            if field_name in self.fields:
                self.fields[field_name].widget = forms.NumberInput(attrs={
                    'class': 'form-control counter-input',
                    'min': '0',
                    'max': info['max'],
                    'step': '1',
                    'data-type': 'counter',
                    'data-unit': info['unit'],
                    'style': 'text-align: left;' # 确保左对齐
                })
                self.fields[field_name].label = f"{self.fields[field_name].label} (最大{info['max']}{info['unit']})"
                
        # 配置百分比字段
        for field_name, label in rate_fields.items():
            if field_name in self.fields:
                self.fields[field_name].widget = forms.NumberInput(attrs={
                    'class': 'form-control rate-input',
                    'min': '0',
                    'max': '100',
                    'step': '1',
                    'data-type': 'percent',
                    'style': 'text-align: left;' # 确保左对齐
                })
                self.fields[field_name].label = f"{label} (%)"

    def clean_homework_score(self):
        score = self.cleaned_data['homework_score']
        if score < 0 or score > 100:
            raise forms.ValidationError("作业成绩必须在0-100之间")
        return score
        
    def clean_sign_in_score(self):
        score = self.cleaned_data['sign_in_score']
        if score < 0 or score > 100:
            raise forms.ValidationError("签到得分必须在0-100之间")
        return score
        
    def clean_test_completion_count(self):
        count = self.cleaned_data['test_completion_count']
        if count < 0 or count > 10:  # 限制最大值为10
            raise forms.ValidationError("测验完成次数必须在0-10之间")
        return count
        
    def clean_homework_completion_count(self):
        count = self.cleaned_data['homework_completion_count']
        if count < 0 or count > 20:  # 限制最大值为20
            raise forms.ValidationError("作业完成次数必须在0-20之间")
        return count
        
    def clean_course_interaction_score(self):
        score = self.cleaned_data['course_interaction_score']
        if score < 0 or score > 100:
            raise forms.ValidationError("课程互动得分必须在0-100之间")
        return score
        
    # 百分比字段清洗函数，将整数百分比转换为小数
    def clean_training_pass_rate_percent(self):
        rate = self.cleaned_data['training_pass_rate_percent']
        if rate < 0 or rate > 100:
            raise forms.ValidationError("实训通过率必须在0-100之间")
        return rate / 100
        
    def clean_test_completion_rate_percent(self):
        rate = self.cleaned_data['test_completion_rate_percent']
        if rate < 0 or rate > 100:
            raise forms.ValidationError("测验完成率必须在0-100之间")
        return rate / 100
        
    def clean_homework_completion_rate_percent(self):
        rate = self.cleaned_data['homework_completion_rate_percent']
        if rate < 0 or rate > 100:
            raise forms.ValidationError("作业完成率必须在0-100之间")
        return rate / 100
        
    def clean_video_watch_rate_percent(self):
        rate = self.cleaned_data['video_watch_rate_percent']
        if rate < 0 or rate > 100:
            raise forms.ValidationError("视频观看率必须在0-100之间")
        return rate / 100
        
    def save(self, commit=True):
        instance = super().save(commit=False)
        
        # 将百分比字段的值保存到模型字段
        instance.training_pass_rate = self.cleaned_data['training_pass_rate_percent']
        instance.test_completion_rate = self.cleaned_data['test_completion_rate_percent']
        instance.homework_completion_rate = self.cleaned_data['homework_completion_rate_percent']
        instance.video_watch_rate = self.cleaned_data['video_watch_rate_percent']
        
        if commit:
            instance.save()
            
        return instance

class StudentRegistrationForm(UserCreationForm):
    name = forms.CharField(max_length=100, label='姓名', help_text='必填项。')
    gender = forms.ChoiceField(choices=UserProfile.GENDER_CHOICES, label='性别', required=False)

    class Meta(UserCreationForm.Meta):
        model = User
        fields = UserCreationForm.Meta.fields + ('email',)

    @transaction.atomic
    def save(self, commit=True):
        user = super().save(commit=False)
        user.is_staff = False
        user.is_active = True

        # Set user's first_name which our signal might use for UserProfile.name
        # This form collects 'name' which is more like a full name.
        # Django's User model has first_name and last_name.
        # Let's assume 'name' from form should be user.first_name for simplicity,
        # or you might want to parse it.
        user.first_name = self.cleaned_data.get('name', '') # Store name in user.first_name

        if commit:
            user.save() # This will trigger the post_save signal that creates/updates UserProfile

            # The signal create_or_update_user_profile is responsible for:
            # 1. Creating UserProfile if it doesn't exist.
            # 2. Setting UserProfile.name based on user.first_name or user.username.
            # 3. Auto-generating UserProfile.student_id.
            # 4. Setting default UserProfile.gender and UserProfile.role.

            # Now, we explicitly update the gender on the UserProfile instance
            # that was created/updated by the signal.
            # The name should have been handled by the signal based on user.first_name.
            # If the signal's name logic is:
            #   profile.name = instance.first_name or instance.username
            # then setting user.first_name above should suffice for the name.

            # Explicitly set gender from the form, as the signal sets a default.
            if hasattr(user, 'userprofile'): # Ensure profile exists
                user.userprofile.gender = self.cleaned_data.get('gender')
                user.userprofile.save(update_fields=['gender']) # Save only gender

        return user

class AdminRegistrationForm(UserCreationForm):
    """
    管理员注册表单
    """
    email = forms.EmailField(required=True, help_text="必填项。")
    name = forms.CharField(max_length=100, label='姓名', required=False, help_text='可选，用于显示。可与用户名一致。' )

    class Meta(UserCreationForm.Meta):
        model = User
        fields = UserCreationForm.Meta.fields + ('email', 'first_name', 'last_name')

    @transaction.atomic
    def save(self, commit=True):
        user = super().save(commit=False)
        user.is_staff = True
        user.is_active = True # New admin users are active by default
        
        # Use cleaned_data for first_name and last_name if provided by UserCreationForm by default
        # or if you add them to the form directly.
        # For now, assuming first_name, last_name are part of UserCreationForm.Meta.fields

        if commit:
            user.save()
        
        # Ensure UserProfile is created and role is set to admin
        user_profile, created = UserProfile.objects.get_or_create(user=user)
        user_profile.role = 'admin'
        # Populate name from form if provided (and if different from User's first/last name logic)
        form_name = self.cleaned_data.get('name')
        if form_name:
            user_profile.name = form_name
        elif user.first_name or user.last_name: # Fallback to user's first/last name for UserProfile.name
            user_profile.name = f"{user.first_name} {user.last_name}".strip()
        else:
            user_profile.name = user.username # Fallback to username
            
        if commit:
            user_profile.save()
        return user

class CustomAuthenticationForm(AuthenticationForm):
    """
    自定义登录表单，可以添加样式等
    """
    username = forms.CharField(widget=forms.TextInput(attrs={'class': 'form-control', 'placeholder': '用户名', 'autofocus': True}))
    password = forms.CharField(widget=forms.PasswordInput(attrs={'class': 'form-control', 'placeholder': '密码'}))

class StudentRecordEditForm(forms.ModelForm):
    """专门用于编辑学生记录的表单，不包含用户选择字段"""
    
    # 定义百分比字段，在表单处理时转换
    training_pass_rate_percent = forms.IntegerField(
        min_value=0, max_value=100, 
        label="实训通过率",
        widget=forms.NumberInput(attrs={'class': 'form-control', 'step': '1'})
    )
    
    test_completion_rate_percent = forms.IntegerField(
        min_value=0, max_value=100, 
        label="测验完成率",
        widget=forms.NumberInput(attrs={'class': 'form-control', 'step': '1'})
    )
    
    homework_completion_rate_percent = forms.IntegerField(
        min_value=0, max_value=100, 
        label="作业完成率",
        widget=forms.NumberInput(attrs={'class': 'form-control', 'step': '1'})
    )
    
    video_watch_rate_percent = forms.IntegerField(
        min_value=0, max_value=100, 
        label="视频观看率",
        widget=forms.NumberInput(attrs={'class': 'form-control', 'step': '1'})
    )

    class Meta:
        model = StudentRecord
        fields = [
            'homework_score', 
            'training_pass_rate_percent',
            'test_completion_rate_percent',
            'sign_in_score', 
            'homework_completion_rate_percent',
            'video_watch_rate_percent',
            'test_completion_count', 
            'homework_completion_count', 
            'course_interaction_score'
        ]
        exclude = [
            'user',  # 明确排除用户字段
            'training_pass_rate',
            'test_completion_rate',
            'homework_completion_rate',
            'video_watch_rate'
        ]
        
    def __init__(self, *args, **kwargs):
        instance = kwargs.get('instance')
        initial = kwargs.get('initial', {})
        
        # 如果是编辑现有记录，将小数比率转换为百分比整数
        if instance:
            # 处理百分比字段
            initial['training_pass_rate_percent'] = int(instance.training_pass_rate * 100)
            initial['test_completion_rate_percent'] = int(instance.test_completion_rate * 100)
            initial['homework_completion_rate_percent'] = int(instance.homework_completion_rate * 100)
            initial['video_watch_rate_percent'] = int(instance.video_watch_rate * 100)
            
            # 处理分数字段，格式化为一位小数
            initial['homework_score'] = round(instance.homework_score, 1)
            initial['sign_in_score'] = round(instance.sign_in_score, 1)
            initial['course_interaction_score'] = round(instance.course_interaction_score, 1)
            
            kwargs['initial'] = initial
            
        super().__init__(*args, **kwargs)
        
        # 配置分数字段
        score_fields = {
            'homework_score': '作业成绩',
            'sign_in_score': '签到分数',
            'course_interaction_score': '课程互动分数'
        }
        
        # 配置计数器字段
        counter_fields = {
            'test_completion_count': {'max': 10, 'unit': '次'},  # 最大10次测验
            'homework_completion_count': {'max': 20, 'unit': '次'}  # 最大20次作业
        }
        
        # 配置比率字段标签
        rate_fields = {
            'training_pass_rate_percent': '实训通过率',
            'test_completion_rate_percent': '测验完成率',
            'homework_completion_rate_percent': '作业完成率',
            'video_watch_rate_percent': '视频观看率'
        }

        # 配置分数型字段
        for field_name, label in score_fields.items():
            if field_name in self.fields:
                self.fields[field_name].widget = forms.NumberInput(attrs={
                    'class': 'form-control score-input',
                    'min': '0',
                    'max': '100',
                    'step': '0.1',
                    'data-type': 'score',
                    'inputmode': 'decimal',
                    'style': 'text-align: left;' # 确保左对齐
                })
                self.fields[field_name].label = f"{label} (0-100分)"
                
        # 配置计数器字段
        for field_name, info in counter_fields.items():
            if field_name in self.fields:
                self.fields[field_name].widget = forms.NumberInput(attrs={
                    'class': 'form-control counter-input',
                    'min': '0',
                    'max': info['max'],
                    'step': '1',
                    'data-type': 'counter',
                    'data-unit': info['unit'],
                    'style': 'text-align: left;' # 确保左对齐
                })
                self.fields[field_name].label = f"{self.fields[field_name].label} (最大{info['max']}{info['unit']})"
                
        # 配置百分比字段
        for field_name, label in rate_fields.items():
            if field_name in self.fields:
                self.fields[field_name].widget = forms.NumberInput(attrs={
                    'class': 'form-control rate-input',
                    'min': '0',
                    'max': '100',
                    'step': '1',
                    'data-type': 'percent',
                    'style': 'text-align: left;' # 确保左对齐
                })
                self.fields[field_name].label = f"{label} (%)"
    
    # 清洗方法与StudentRecordForm相同
    def clean_homework_score(self):
        score = self.cleaned_data['homework_score']
        if score < 0 or score > 100:
            raise forms.ValidationError("作业成绩必须在0-100之间")
        return score
        
    def clean_sign_in_score(self):
        score = self.cleaned_data['sign_in_score']
        if score < 0 or score > 100:
            raise forms.ValidationError("签到得分必须在0-100之间")
        return score
        
    def clean_test_completion_count(self):
        count = self.cleaned_data['test_completion_count']
        if count < 0 or count > 10:  # 限制最大值为10
            raise forms.ValidationError("测验完成次数必须在0-10之间")
        return count
        
    def clean_homework_completion_count(self):
        count = self.cleaned_data['homework_completion_count']
        if count < 0 or count > 20:  # 限制最大值为20
            raise forms.ValidationError("作业完成次数必须在0-20之间")
        return count
        
    def clean_course_interaction_score(self):
        score = self.cleaned_data['course_interaction_score']
        if score < 0 or score > 100:
            raise forms.ValidationError("课程互动得分必须在0-100之间")
        return score
        
    # 百分比字段清洗函数，将整数百分比转换为小数
    def clean_training_pass_rate_percent(self):
        rate = self.cleaned_data['training_pass_rate_percent']
        if rate < 0 or rate > 100:
            raise forms.ValidationError("实训通过率必须在0-100之间")
        return rate / 100
        
    def clean_test_completion_rate_percent(self):
        rate = self.cleaned_data['test_completion_rate_percent']
        if rate < 0 or rate > 100:
            raise forms.ValidationError("测验完成率必须在0-100之间")
        return rate / 100
        
    def clean_homework_completion_rate_percent(self):
        rate = self.cleaned_data['homework_completion_rate_percent']
        if rate < 0 or rate > 100:
            raise forms.ValidationError("作业完成率必须在0-100之间")
        return rate / 100
        
    def clean_video_watch_rate_percent(self):
        rate = self.cleaned_data['video_watch_rate_percent']
        if rate < 0 or rate > 100:
            raise forms.ValidationError("视频观看率必须在0-100之间")
        return rate / 100
        
    def save(self, commit=True):
        instance = super().save(commit=False)
        
        # 将百分比字段的值保存到模型字段
        instance.training_pass_rate = self.cleaned_data['training_pass_rate_percent']
        instance.test_completion_rate = self.cleaned_data['test_completion_rate_percent']
        instance.homework_completion_rate = self.cleaned_data['homework_completion_rate_percent']
        instance.video_watch_rate = self.cleaned_data['video_watch_rate_percent']
        
        if commit:
            instance.save()
            
        return instance