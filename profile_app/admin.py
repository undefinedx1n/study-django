from django.contrib import admin
from .models import UserProfile, StudentRecord, ClusterResult, ModelLog
from django import forms
from dal import autocomplete
from django.contrib.auth.models import User

@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'name', 'student_id', 'gender', 'role')
    list_filter = ('role', 'gender')
    search_fields = ('user__username', 'name', 'student_id')
    readonly_fields = ('student_id',)
    fieldsets = (
        (None, {
            'fields': ('user', 'role')
        }),
        ('个人信息', {
            'fields': ('name', 'student_id', 'gender')
        }),
    )

class StudentRecordAdminForm(forms.ModelForm):
    user = forms.ModelChoiceField(
        queryset=User.objects.all(),
        label='学生用户',
        widget=autocomplete.ModelSelect2(url='profile_app:user-student-autocomplete')
    )

    class Meta:
        model = StudentRecord
        fields = '__all__'

    def clean_user(self):
        user = self.cleaned_data.get('user')
        if not user:
            raise forms.ValidationError("必须选择一个学生用户。")
        
        if not hasattr(user, 'userprofile') or user.userprofile is None:
            try:
                user.refresh_from_db(fields=['userprofile'])
            except User.userprofile.RelatedObjectDoesNotExist: # type: ignore
                raise forms.ValidationError("选择的用户没有关联的用户画像信息。")

        if user.userprofile.role != UserProfile.RoleChoices.STUDENT:
            raise forms.ValidationError(f"选择的用户 '{user}' 不是学生角色，而是 '{user.userprofile.get_role_display()}'。请从搜索结果中选择有效的学生用户。")
        
        return user

@admin.register(StudentRecord)
class StudentRecordAdmin(admin.ModelAdmin):
    form = StudentRecordAdminForm
    list_display = ('id', 'user_link', 'homework_score', 'final_score_from_cluster', 'rating_from_cluster', 'create_time')
    list_filter = ('create_time',)
    search_fields = ('user__username', 'user__userprofile__name', 'id')
    readonly_fields = ('create_time', 'update_time')

    def user_link(self, obj):
        from django.urls import reverse
        from django.utils.html import format_html
        if obj.user:
            if hasattr(obj.user, 'userprofile') and obj.user.userprofile.name:
                display_name = obj.user.userprofile.name
            else:
                display_name = obj.user.username
            link = reverse("admin:auth_user_change", args=[obj.user.id])
            return format_html('<a href="{}">{}</a>', link, display_name)
        return "N/A"
    user_link.short_description = '学生用户'
    user_link.admin_order_field = 'user__username'

    def final_score_from_cluster(self, obj):
        if hasattr(obj, 'cluster_result') and obj.cluster_result:
            return obj.cluster_result.final_score
        return "N/A"
    final_score_from_cluster.short_description = '画像总分'

    def rating_from_cluster(self, obj):
        if hasattr(obj, 'cluster_result') and obj.cluster_result:
            return obj.cluster_result.rating
        return "N/A"
    rating_from_cluster.short_description = '画像评级'

    def get_queryset(self, request):
        queryset = super().get_queryset(request)
        return queryset.select_related('user__userprofile', 'cluster_result')

@admin.register(ClusterResult)
class ClusterResultAdmin(admin.ModelAdmin):
    list_display = ('student_record_link', 'cluster_id', 'final_score', 'rating', 'knowledge_dimension_score', 'attitude_dimension_score', 'interest_dimension_score', 'create_time')
    list_filter = ('rating', 'cluster_id', 'create_time')
    search_fields = ('student_record__user__username', 'student_record__user__userprofile__name')
    readonly_fields = ('create_time', 'update_time')
    list_select_related = ('student_record__user__userprofile',)

    def student_record_link(self, obj):
        from django.urls import reverse
        from django.utils.html import format_html
        if obj.student_record and obj.student_record.user:
            if hasattr(obj.student_record.user, 'userprofile') and obj.student_record.user.userprofile.name:
                display_name = obj.student_record.user.userprofile.name
            else:
                display_name = obj.student_record.user.username
            link = reverse("admin:profile_app_studentrecord_change", args=[obj.student_record.id])
            return format_html('<a href="{}">{} (ID:{})</a>', link, display_name, obj.student_record.id)
        return "N/A"
    student_record_link.short_description = '学生记录'

@admin.register(ModelLog)
class ModelLogAdmin(admin.ModelAdmin):
    list_display = ('id', 'train_time', 'model_type', 'sample_count_from_metrics', 'total_sse_from_metrics', 'silhouette_score_from_metrics')
    list_filter = ('train_time', 'model_type')
    readonly_fields = ('train_time', 'performance_metrics', 'parameters', 'notes')

    def sample_count_from_metrics(self, obj):
        return obj.performance_metrics.get('sample_count', 'N/A') if obj.performance_metrics else 'N/A'
    sample_count_from_metrics.short_description = '样本数'

    def total_sse_from_metrics(self, obj):
        return obj.performance_metrics.get('total_sse', 'N/A') if obj.performance_metrics else 'N/A'
    total_sse_from_metrics.short_description = '总SSE'

    def silhouette_score_from_metrics(self, obj):
        return obj.performance_metrics.get('silhouette_score', 'N/A') if obj.performance_metrics else 'N/A'
    silhouette_score_from_metrics.short_description = '轮廓系数'
