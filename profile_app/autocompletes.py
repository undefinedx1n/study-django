from dal import autocomplete
from django.contrib.auth.models import User
from .models import UserProfile
import logging

# 获取日志记录器
logger = logging.getLogger(__name__)

class UserStudentAutocomplete(autocomplete.Select2QuerySetView):
    def get_queryset(self):
        try:
            # 初始查询集 - 筛选出角色为学生的用户
            if not self.request.user.is_authenticated:
                logger.warning("未授权用户尝试访问学生自动完成功能")
                return User.objects.none()

            # 使用字符串 'student' 而不是 UserProfile.RoleChoices.STUDENT
            qs = User.objects.filter(
                userprofile__role='student',
                userprofile__isnull=False
            ).select_related('userprofile')
            
            logger.debug(f"基础查询获取到 {qs.count()} 个学生用户")
            
            # 只有当有用户输入时才进行搜索
            if self.q:
                logger.debug(f"收到搜索查询: {self.q}")
                # 支持按用户名、姓名或学号搜索
                result_qs = qs.filter(
                    # 用户名搜索
                    username__icontains=self.q
                ) | qs.filter(
                    # 用户的姓名搜索
                    userprofile__name__icontains=self.q
                ) | qs.filter(
                    # 学号搜索
                    userprofile__student_id__icontains=self.q
                )
                logger.debug(f"搜索 '{self.q}' 找到 {result_qs.count()} 个匹配结果")
                return result_qs
            return qs
        except Exception as e:
            logger.error(f"自动完成视图发生错误: {str(e)}", exc_info=True)
            # 发生错误时，返回空查询集，避免500错误
            return User.objects.none()

    def get_result_label(self, result):
        try:
            # 自定义下拉列表中每个选项的显示方式
            if hasattr(result, 'userprofile') and result.userprofile.name:
                return f"{result.userprofile.name} ({result.username}, 学号: {result.userprofile.student_id or '未设置'})"
            return f"{result.username} (学号: {getattr(result.userprofile, 'student_id', '未设置') or '未设置'})"
        except Exception as e:
            logger.error(f"获取结果标签时发生错误: {str(e)}", exc_info=True)
            return f"{result.username} (加载详情出错)"

    def get_selected_result_label(self, result):
        try:
            # 自定义已选择项的显示方式
            return self.get_result_label(result)
        except Exception as e:
            logger.error(f"获取选定结果标签时发生错误: {str(e)}", exc_info=True)
            return f"{result.username} (加载详情出错)"

# 你也可以为其他模型创建类似的自动完成类
# 例如，如果 StudentRecord 也需要被其他模型引用并搜索
# al.register(StudentRecord, name='StudentRecordAutocomplete', search_fields=['id', 'user__userprofile__name']) 