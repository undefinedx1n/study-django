from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.http import JsonResponse, HttpResponse
from .forms import StudentRecordForm, StudentRecordEditForm, AdminRegistrationForm, CustomAuthenticationForm, StudentRegistrationForm
from .ml_utils import LearnerProfileAnalyzer
from .models import StudentRecord, ClusterResult, ModelLog, UserProfile, User
from .exceptions import InsufficientDataError, DataAnalysisError
from django.db.models import Avg, F, Count, Q, Prefetch, Exists, OuterRef, Subquery, Case, When, Value, IntegerField
import logging
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth.views import LoginView, LogoutView
from django.contrib.auth import login
from django.urls import reverse_lazy
from django.views.generic import CreateView
from django.core.paginator import Paginator, PageNotAnInteger, EmptyPage
import csv

# 配置日志
logger = logging.getLogger(__name__)

# --- 辅助权限检查函数 ---
def staff_member_required(view_func):
    """
    装饰器，检查用户是否是 staff member。
    """
    decorated_view_func = login_required(user_passes_test(
        lambda u: u.is_active and u.is_staff,
        login_url='profile_app:login' # 如果检查失败，重定向到登录页面
    )(view_func))
    return decorated_view_func

# --- 添加管理员仪表盘视图 ---
@staff_member_required
def admin_dashboard(request):
    """管理员控制台首页，显示系统概览数据"""
    # 获取现有统计数据
    student_count = UserProfile.objects.filter(role='student').count()
    analyzed_count = ClusterResult.objects.count() # 已有画像结果的记录数
    
    # "待处理数据" 指的是已有StudentRecord但还没有ClusterResult的记录
    student_records_with_data = StudentRecord.objects.all()
    # total_student_records = student_records_with_data.count() # 如果需要总学习记录数，可以取消注释
    
    # 学生记录中，没有对应画像结果的记录ID
    analyzed_record_ids = ClusterResult.objects.values_list('student_record_id', flat=True)
    pending_analysis_records = student_records_with_data.exclude(id__in=analyzed_record_ids)
    pending_analysis_count = pending_analysis_records.count()

    pending_analysis_details = None
    if pending_analysis_count > 0:
        pending_analysis_samples = pending_analysis_records.select_related('user__userprofile').order_by('-create_time')[:3] # 取最新的3条
        pending_analysis_details = {
            'records': pending_analysis_samples, # 这里是 StudentRecord 对象列表
            'total': pending_analysis_count,
            'sample_count': min(pending_analysis_count, 3)
        }
    
    # 新增：获取"注册后待添加学习数据的学生"
    # 这些学生有 UserProfile (role='student') 但没有 StudentRecord
    users_pending_data_input = User.objects.filter(
        userprofile__role=UserProfile.ROLE_STUDENT, # Using the defined constant
        student_records__isnull=True # student_records 是 StudentRecord.user 的 related_name
    ).distinct()
    
    students_pending_data_input_count = users_pending_data_input.count()
    
    students_pending_data_input_details = None
    if students_pending_data_input_count > 0:
        # 获取一些样本学生（例如，最新注册的3个）
        pending_input_samples = users_pending_data_input.select_related('userprofile').order_by('-date_joined')[:3]
        students_pending_data_input_details = {
            'users': pending_input_samples, # 注意这里是 User 对象列表
            'total': students_pending_data_input_count,
            'sample_count': min(students_pending_data_input_count, 3)
        }

    latest_model = ModelLog.objects.order_by('-train_time').first()
    
    context = {
        'student_count': student_count, # 总学生用户数
        'analyzed_count': analyzed_count, # 已完成画像分析的学生记录数
        'pending_analysis_count': pending_analysis_count, # 有学习记录但待分析的数量
        'pending_analysis_details': pending_analysis_details, # 待分析的样本 (原 pending_details)
        
        'students_pending_data_input_count': students_pending_data_input_count, # 新增：待录入学习数据的学生数
        'students_pending_data_input_details': students_pending_data_input_details, # 新增：待录入数据的学生样本
        
        'latest_model': latest_model,
        # 'total_student_records': total_student_records, # 如果需要总学习记录数，传递到context
    }
    
    return render(request, 'admin_dashboard.html', context)

# --- 新增认证视图 ---
class AdminSignUpView(CreateView):
    form_class = AdminRegistrationForm
    template_name = 'registration/admin_signup.html' # 需要创建此模板
    success_url = reverse_lazy('profile_app:login') # 注册成功后跳转到登录

    def dispatch(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            # 如果用户已登录，重定向到首页或管理员仪表盘
            # 避免已登录用户访问注册页面
            return redirect('profile_app:index') 
        return super().dispatch(request, *args, **kwargs)

    def form_valid(self, form):
        # 可以选择在这里自动登录用户，或让他们手动登录
        user = form.save()
        # login(self.request, user) # 可选：注册后自动登录
        messages.success(self.request, "管理员账户注册成功，请登录。")
        return super().form_valid(form)

class AdminLoginView(LoginView):
    form_class = CustomAuthenticationForm
    template_name = 'registration/login.html'

    def _is_student(self, user):
        if user.is_authenticated and user.is_active:
            try:
                if hasattr(user, 'userprofile') and user.userprofile.role == UserProfile.ROLE_STUDENT:
                    return True
            except UserProfile.DoesNotExist: # More specific catch
                logger.warning(f"UserProfile.DoesNotExist for user {user.username} during login role check.")
                return False
            except AttributeError: # Catch if userprofile itself is problematic
                logger.warning(f"AttributeError for user {user.username} during login role check on userprofile.")
                return False
        return False

    def dispatch(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            is_student_user = self._is_student(request.user)
            
            if request.user.is_staff:
                return redirect(reverse_lazy('admin_dashboard'))
            elif is_student_user:
                return redirect(reverse_lazy('profile_app:student_dashboard'))
            else:
                messages.info(request, "您的账户类型无法确定或不适用，已重定向到首页。")
                return redirect(reverse_lazy('profile_app:index')) 
        return super().dispatch(request, *args, **kwargs)

    def get_success_url(self):
        user = self.request.user
        
        redirect_to = self.get_redirect_url() # 优先处理 next 参数
        if redirect_to:
            return redirect_to

        # 如果没有 next 参数，根据角色重定向
        if user.is_authenticated:
            if user.is_staff:
                return reverse_lazy('admin_dashboard') # 指向全局 'admin_dashboard'
            elif self._is_student(user): 
                return reverse_lazy('profile_app:student_dashboard')
        
        # 默认或回退到首页
        return reverse_lazy('profile_app:index')

class AdminLogoutView(LogoutView):
    # LOGOUT_REDIRECT_URL 将在 settings.py 中定义, 例如 'profile_app:login'
    # next_page = reverse_lazy('profile_app:login') # 或者在这里硬编码
    pass

class StudentSignUpView(CreateView):
    form_class = StudentRegistrationForm
    template_name = 'registration/student_signup.html' 
    success_url = reverse_lazy('profile_app:login') # 学生注册成功后跳转到登录页面

    def dispatch(self, request, *args, **kwargs):
        if request.user.is_authenticated:
            if request.user.is_staff:
                # Staff accessing student signup, redirect them to a relevant staff page
                messages.info(request, "管理员请使用管理后台功能。")
                return redirect('admin_dashboard') # 修改这里
            elif hasattr(request.user, 'userprofile') and request.user.userprofile.role == UserProfile.ROLE_STUDENT: # Use constant
                messages.info(request, "您已作为学生登录，无需再次注册。")
                return redirect('profile_app:student_dashboard') # Redirect to student dashboard
            else:
                # Other authenticated users (e.g., no profile, unknown role)
                messages.info(request, "您已登录，但账户类型无法处理此请求。")
                return redirect('profile_app:index') 
        return super().dispatch(request, *args, **kwargs)

    def form_valid(self, form):
        user = form.save()
        messages.success(self.request, "学生账户注册成功！请使用您的用户名和密码登录。")
        # 不在此处自动登录学生，让他们通过登录流程熟悉操作
        return super().form_valid(form)

# --- Custom Decorators (Optional but good practice) ---
def student_required(view_func):
    """Decorator for views that require student role"""
    @login_required(login_url='profile_app:login')
    def _wrapped_view(request, *args, **kwargs):
        is_student = False
        if request.user.is_authenticated and request.user.is_active:
            try:
                # Check if userprofile exists and role is student
                if request.user.userprofile.role == UserProfile.ROLE_STUDENT:
                    is_student = True
            except UserProfile.DoesNotExist:
                # UserProfile does not exist for this user
                logger.warning(f"UserProfile.DoesNotExist for user {request.user.username} in @student_required.")
                pass # is_student remains False
            except AttributeError:
                # This might happen if userprofile is None or not properly set up,
                # though DoesNotExist should ideally catch it if it's a missing related object.
                logger.warning(f"AttributeError accessing userprofile for user {request.user.username} in @student_required.")
                pass # is_student remains False
        
        if not is_student:
            messages.error(request, "您没有权限访问此页面。请确保您以有效的学生账户登录。")
            return redirect('profile_app:login')
        return view_func(request, *args, **kwargs)
    return _wrapped_view

# --- Student Dashboard Placeholder ---
@student_required
def student_dashboard_view(request):
    user = request.user
    try:
        # 获取当前登录学生的用户画像、学习记录和聚类结果
        # UserProfile 通常是通过 user.userprofile 访问，这里主要是为了获取姓名等
        user_profile = UserProfile.objects.get(user=user)
        student_record = StudentRecord.objects.get(user=user)
        cluster_result = ClusterResult.objects.get(student_record=student_record)

        # 准备雷达图数据 (与 radar_chart 视图类似)
        radar_data = {
            'knowledge_skill': cluster_result.knowledge_dimension_score,
            'learning_attitude': cluster_result.attitude_dimension_score,
            'course_interest': cluster_result.interest_dimension_score,
            'final_score': cluster_result.final_score
        }
        
        score_interpretations = {
            'knowledge_skill': get_score_level_description(cluster_result.knowledge_dimension_score, '知识技能'),
            'learning_attitude': get_score_level_description(cluster_result.attitude_dimension_score, '学习态度'),
            'course_interest': get_score_level_description(cluster_result.interest_dimension_score, '课程兴趣'),
            'final_score': get_score_level_description(cluster_result.final_score, '综合表现')
        }
        
        score_contributions = calculate_score_contributions(cluster_result)
        recommendations = generate_recommendations(student_record, cluster_result)

        context = {
            'user_profile': user_profile, # 包含姓名等
            'record': student_record, # 原始学习行为数据, 键名从 student_record 改为 record
            'cluster_result': cluster_result, # 画像分析结果
            'radar_data': radar_data,
            'score_interpretations': score_interpretations,
            'score_contributions': score_contributions,
            'recommendations': recommendations,
        }
        return render(request, 'student_dashboard.html', context)

    except UserProfile.DoesNotExist:
        messages.error(request, "您的用户配置信息不存在，请联系管理员。")
        return redirect('profile_app:login') # 或者一个更通用的错误页面
    except StudentRecord.DoesNotExist:
        messages.info(request, "您的学习行为记录尚未录入系统，暂无法生成学习画像。")
        # 可以渲染一个特定的提示页面，或重定向
        return render(request, 'student_dashboard_no_data.html', {'user_profile': user_profile if 'user_profile' in locals() else None})
    except ClusterResult.DoesNotExist:
        messages.info(request, "您的学习画像分析结果正在生成中或尚未完成，请稍后再试。")
        # 可以渲染一个特定的提示页面，或重定向
        return render(request, 'student_dashboard_no_data.html', {
            'user_profile': user_profile if 'user_profile' in locals() else None, 
            'record': student_record if 'student_record' in locals() else None,
            'message_type': 'processing'
        })
    except Exception as e:
        logger.error(f"学生仪表盘视图发生错误 (用户: {user.username}): {str(e)}", exc_info=True)
        messages.error(request, f"加载您的学习画像时发生未知错误: {str(e)}。系统已记录此问题，请稍后重试或联系管理员。")
        # Redirect to index to break the loop, instead of login page
        return redirect('profile_app:index')

# --- 修改现有视图以添加权限控制 ---
@staff_member_required
def index(request):
    # Initial base query for student profiles
    initial_query = UserProfile.objects.filter(role='student').select_related('user')

    # Handle search query
    search_query = request.GET.get('search', '')
    if search_query:
        # Apply search filters
        query_set = initial_query.filter(
            Q(user__username__icontains=search_query) |
            Q(name__icontains=search_query) |
            Q(student_id__icontains=search_query)
        ).distinct()
    else:
        query_set = initial_query

    # 排序：按用户创建时间降序（新的在前），然后按姓名、用户名升序
    query_set = query_set.order_by('-user__date_joined', 'name', 'user__username')

    # Prefetch related data for display AFTER sorting and annotations
    # This is important for pagination to work correctly with prefetched data.
    query_set = query_set.prefetch_related(
        Prefetch(
            'user__student_records',
            queryset=StudentRecord.objects.order_by('-create_time').select_related('cluster_result'),
            to_attr='ordered_records_with_clusters'
        )
    )

    # Pagination processing (remains the same)
    paginator = Paginator(query_set, 15)  # 每页显示10条记录
    page_number = request.GET.get('page', 1)
    try:
        page_obj = paginator.page(page_number)
    except PageNotAnInteger:
        page_obj = paginator.page(1)
    except EmptyPage:
        page_obj = paginator.page(paginator.num_pages)

    return render(request, 'index.html', {
        'student_profiles': page_obj,  # Pass the paginated UserProfile queryset to template
        'page_obj': page_obj,
        'paginator': paginator,
        'is_paginated': True, # paginator.num_pages > 1 can also be used
        'search_query': search_query
    })


@staff_member_required
def data_input(request):
    if request.method == 'POST':
        form = StudentRecordForm(request.POST)
        if form.is_valid():
            record = form.save()
            messages.success(request, f"成功添加 {record.user.userprofile.name if hasattr(record.user, 'userprofile') and record.user.userprofile.name else record.user.username} 的学习记录。请记得稍后手动执行聚类分析以更新学习画像。")
            
            # # 自动执行聚类分析
            # try:
            #     analyzer = LearnerProfileAnalyzer()
            #     success = analyzer.update_model()
            #     if success:
            #         messages.info(request, "聚类分析已自动更新。")
            #     else:
            #         messages.warning(request, "聚类分析未能成功完成。可能数据量不足或数据不满足聚类条件。")
            # except Exception as e:
            #     messages.error(request, f"聚类分析过程中发生错误: {str(e)}")
            
            # 重定向到主页或学生详情页
            return redirect('profile_app:index')
        else:
            messages.error(request, "表单数据验证失败，请修正后重试。")
    else:
        form = StudentRecordForm()
        # 查询待录入数据的学生
        students_pending_initial_record = User.objects.filter(
            userprofile__role='student', 
            student_records__isnull=True
        ).select_related('userprofile').order_by('userprofile__name', 'username')
        
    # 将 form 和 students_pending_initial_record 添加到 context
    context = {
        'form': form,
        'students_pending_initial_record': students_pending_initial_record if request.method != 'POST' else None
    }
    return render(request, 'data_input.html', context)

@staff_member_required
def radar_chart(request, record_id):
    try:
        record = StudentRecord.objects.select_related('user__userprofile').get(id=record_id)
        cluster_result = ClusterResult.objects.get(student_record=record)
    except StudentRecord.DoesNotExist:
        messages.error(request, "未找到指定的学生记录！")
        return redirect('profile_app:index')
    except ClusterResult.DoesNotExist:
        messages.warning(request, f"未找到学生 {record.user.userprofile.name if hasattr(record.user, 'userprofile') else record.user.username} 的画像分析结果，可能需要先运行聚类分析或检查数据。")
        # 可以选择重定向，或者渲染一个提示信息更丰富的页面
        # For now, redirect to index, but ideally, show a page explaining no cluster result exists yet for this student.
        # Or, perhaps, calculate on the fly if that's a desired feature.
        # return redirect('profile_app:index') # Or render a specific template
        # 为简单起见，如果画像不存在，可以只显示学生基本信息和提示
        return render(request, 'result_radar_error.html', {
            'record': record,
            'error_message': f"未找到学生 {record.user.userprofile.name if hasattr(record.user, 'userprofile') else record.user.username} 的详细画像分析结果。"
        })

    # 准备雷达图数据
    radar_data = {
        'knowledge_skill': cluster_result.knowledge_dimension_score,
        'learning_attitude': cluster_result.attitude_dimension_score,
        'course_interest': cluster_result.interest_dimension_score,
        'final_score': cluster_result.final_score
    }
    
    # 为每个维度评分添加解释
    score_interpretations = {
        'knowledge_skill': get_score_level_description(cluster_result.knowledge_dimension_score, '知识技能'),
        'learning_attitude': get_score_level_description(cluster_result.attitude_dimension_score, '学习态度'),
        'course_interest': get_score_level_description(cluster_result.interest_dimension_score, '课程兴趣'),
        'final_score': get_score_level_description(cluster_result.final_score, '综合表现')
    }
    
    # 计算各维度对最终得分的贡献百分比
    score_contributions = calculate_score_contributions(cluster_result)
    
    # 根据原始指标生成具体建议
    recommendations = generate_recommendations(record, cluster_result)

    context = {
        'radar_data': radar_data,
        'score_interpretations': score_interpretations,
        'score_contributions': score_contributions,
        'recommendations': recommendations,
        'record': record,
        'cluster_result': cluster_result
    }

    return render(request, 'result_radar.html', context)


def calculate_dimension_score(record, features, weights=None):
    """
    计算维度得分的辅助函数，支持加权计算
    :param record: 学生记录
    :param features: 特征列表
    :param weights: 权重字典 {特征名: 权重}，如果为None则均等权重
    :return: 加权平均分数
    """
    if weights is None:
        # 均等权重
        return sum(getattr(record, feature) for feature in features) / len(features)
    else:
        # 加权平均
        total_score = sum(getattr(record, feature) * weights.get(feature, 1) for feature in features)
        total_weight = sum(weights.get(feature, 1) for feature in features)
        return total_score / total_weight


def get_score_level_description(score, dimension):
    """获取分数等级描述"""
    if score >= 85:
        return f"{dimension}表现优秀"
    elif score >= 70:
        return f"{dimension}表现良好"
    elif score >= 60:
        return f"{dimension}表现中等"
    elif score >= 45:
        return f"{dimension}表现较低"
    else:
        return f"{dimension}需要提高"
    """根据分数和维度提供详细的文字描述"""
    if dimension == '知识技能':
        if score >= 90:
            return f"优秀 ({score:.1f}分) - 知识掌握全面，技能运用熟练"
        elif score >= 70:
            return f"良好 ({score:.1f}分) - 知识掌握较好，技能运用基本熟练"
        elif score >= 50:
            return f"中等 ({score:.1f}分) - 知识有待巩固，技能运用需加强"
        elif score >= 30:
            return f"较低 ({score:.1f}分) - 知识掌握不足，技能运用欠缺"
        else:
            return f"不足 ({score:.1f}分) - 知识技能水平亟待提高"
    
    elif dimension == '学习态度':
        if score >= 90:
            return f"优秀 ({score:.1f}分) - 学习积极主动，自律性强"
        elif score >= 70:
            return f"良好 ({score:.1f}分) - 学习较为主动，自律性较好"
        elif score >= 50:
            return f"中等 ({score:.1f}分) - 学习态度一般，自律性有待加强"
        elif score >= 30:
            return f"较低 ({score:.1f}分) - 学习态度不够认真，缺乏自律"
        else:
            return f"不足 ({score:.1f}分) - 学习态度较差，自律性严重不足"
    
    elif dimension == '课程兴趣':
        if score >= 90:
            return f"优秀 ({score:.1f}分) - 对课程高度兴趣，参与度很高"
        elif score >= 70:
            return f"良好 ({score:.1f}分) - 对课程兴趣较高，参与度较好"
        elif score >= 50:
            return f"中等 ({score:.1f}分) - 对课程兴趣一般，参与度中等"
        elif score >= 30:
            return f"较低 ({score:.1f}分) - 对课程兴趣不高，参与度不足"
        else:
            return f"不足 ({score:.1f}分) - 对课程缺乏兴趣，参与度很低"
    
    elif dimension == '综合表现':
        if score >= 90:
            return f"优秀 ({score:.1f}分) - 学习全面发展，表现出色"
        elif score >= 70:
            return f"良好 ({score:.1f}分) - 学习较为全面，表现良好"
        elif score >= 50:
            return f"中等 ({score:.1f}分) - 学习基本达标，表现一般"
        elif score >= 30:
            return f"较低 ({score:.1f}分) - 学习有明显不足，需要改进"
        else:
            return f"不足 ({score:.1f}分) - 学习存在严重问题，急需全面提高"
    
    return f"{score:.1f}分"


def calculate_score_contributions(cluster_result):
    """计算各维度对最终得分的贡献百分比"""
    # 使用与ml_utils.py中相同的权重
    weights = {
        'knowledge_skill': 0.5,
        'learning_attitude': 0.3,
        'course_interest': 0.2
    }
    
    contributions = {
        'knowledge_skill': weights['knowledge_skill'] * cluster_result.knowledge_dimension_score,
        'learning_attitude': weights['learning_attitude'] * cluster_result.attitude_dimension_score,
        'course_interest': weights['course_interest'] * cluster_result.interest_dimension_score
    }
    
    # 计算每个维度的贡献百分比
    total = sum(contributions.values())
    if total > 0:
        for key in contributions:
            contributions[key] = (contributions[key] / total) * 100
    
    return contributions


def generate_recommendations(record, cluster_result):
    """根据学生表现生成针对性建议"""
    recommendations = {}
    
    # 针对知识技能维度的建议
    if cluster_result.knowledge_dimension_score < 60:
        if record.homework_score < 60:
            recommendations['homework'] = "建议加强作业完成质量，注重理解而非简单完成。关注作业中的关键知识点，确保理解每个概念的本质。"
        if record.training_pass_rate < 60:
            recommendations['training'] = "建议增加实训练習时间，提高技能掌握程度。通过多次练习巩固技能，可以从简单案例逐步过渡到复杂案例。"
        if record.test_completion_rate < 60:
            recommendations['test'] = "建议提高测验完成率，巩固知识点掌握。测验是检验学习效果的重要手段，完成后应回顾错题，强化薄弱环节。"
    
    # 针对学习态度维度的建议
    if cluster_result.attitude_dimension_score < 60:
        if record.sign_in_score < 60:
            recommendations['attendance'] = "建议提高课程出勤率，保持学习连续性。规律的课程参与能够帮助构建完整的知识体系，减少学习断点。"
        if record.homework_completion_rate < 60:
            recommendations['homework_completion'] = "建议按时完成所有作业，培养学习责任感。制定合理的学习计划，避免临时抱佛脚带来的学习压力。"
        if record.video_watch_rate < 60:
            recommendations['video_watch'] = "建议完整观看教学视频，不要跳过重要内容。教学视频中的案例分析和重点解释对理解知识点至关重要。"
    
    # 针对课程兴趣维度的建议
    if cluster_result.interest_dimension_score < 60:
        if record.course_interaction_score < 60:
            recommendations['interaction'] = "建议增加课程互动，主动提问和参与讨论。课堂讨论能加深对知识的理解，同时培养批判性思维能力。"
        if (record.test_completion_count + record.homework_completion_count) < 10:
            recommendations['participation'] = "建议增加课程参与度，尝试完成更多扩展性任务。主动探索课程相关知识，将学习与实际应用场景结合起来。"
    
    # 即便成绩较好，也提供一些激励性建议
    if len(recommendations) == 0 and cluster_result.final_score >= 75:
        recommendations['general'] = "您的学习表现良好！可以尝试帮助其他同学，分享学习经验，这不仅能巩固自己的知识，也能提升表达能力。"
    
    return recommendations


def calculate_engagement_components(student_record):
    """计算单个学生的学习积极性各组成部分"""
    # 课程互动得分 (30%)
    interaction_score = float(student_record.course_interaction_score) * 0.3
    
    # 视频学习投入度 (25%)
    video_engagement = float(student_record.video_watch_rate) * 100 * 0.25
    
    # 作业参与度 (25%) - 结合完成率和次数
    homework_engagement = (
        float(student_record.homework_completion_rate) * 100 * 0.6 +
        (float(student_record.homework_completion_count) / 20) * 100 * 0.4
    ) * 0.25
    
    # 测验参与度 (20%) - 结合完成率和次数
    test_engagement = (
        float(student_record.test_completion_rate) * 100 * 0.6 +
        (float(student_record.test_completion_count) / 10) * 100 * 0.4
    ) * 0.2
    
    return {
        'interaction': interaction_score,
        'video': video_engagement,
        'homework': homework_engagement,
        'test': test_engagement,
        'total': interaction_score + video_engagement + homework_engagement + test_engagement
    }

def get_engagement_level(score):
    """根据积极性得分返回等级和描述"""
    if score >= 90:
        return {
            'level': '优秀',
            'description': '全方位高度参与，表现突出',
            'class': 'bg-success'
        }
    elif score >= 75:
        return {
            'level': '良好',
            'description': '整体参与度较高，个别方面有待提高',
            'class': 'bg-info'
        }
    elif score >= 60:
        return {
            'level': '中等',
            'description': '基本参与各项活动，积极性一般',
            'class': 'bg-warning'
        }
    else:
        return {
            'level': '待提高',
            'description': '参与度不足，需要重点关注',
            'class': 'bg-danger'
        }

def calculate_class_engagement_stats(cluster_results):
    """计算班级整体的学习积极性统计数据"""
    engagement_scores = []
    component_totals = {
        'interaction': 0,
        'video': 0,
        'homework': 0,
        'test': 0
    }
    
    for result in cluster_results:
        components = calculate_engagement_components(result.student_record)
        engagement_scores.append(components['total'])
        
        for key in component_totals:
            component_totals[key] += components[key]
    
    total_students = len(cluster_results)
    if total_students == 0:
        return None
        
    # 计算班级平均值
    avg_components = {
        key: round(total / total_students, 1)
        for key, total in component_totals.items()
    }
    
    # 计算班级总体积极性得分
    avg_engagement = round(sum(engagement_scores) / total_students, 1)
    
    # 统计各等级人数
    level_counts = {
        '优秀': sum(1 for score in engagement_scores if score >= 90),
        '良好': sum(1 for score in engagement_scores if 75 <= score < 90),
        '中等': sum(1 for score in engagement_scores if 60 <= score < 75),
        '待提高': sum(1 for score in engagement_scores if score < 60)
    }
    
    return {
        'average_score': avg_engagement,
        'level_counts': level_counts,
        'components': avg_components,
        'level_info': get_engagement_level(avg_engagement)
    }

@staff_member_required
def cluster_analysis(request):
    try:
        # 使用select_related优化查询，并使用正确的字段名 student_record
        cluster_results = ClusterResult.objects.select_related('student_record__user__userprofile').all()
        
        # 基础统计
        total_students = len(cluster_results)
        if total_students == 0:
            messages.warning(request, "暂无学生数据")
            return render(request, 'cluster_analysis.html', {'cluster_stats': {'total_students': 0}})
        
        # 使用列表推导优化计算
        scores = [float(result.final_score) for result in cluster_results]
        excellent_count = sum(1 for score in scores if score >= 90)
        good_count = sum(1 for score in scores if 70 <= score < 90)
        average_count = sum(1 for score in scores if 50 <= score < 70)
        poor_count = sum(1 for score in scores if score < 50)
        
        # 计算统计数据
        excellent_rate = round((excellent_count / total_students * 100), 1) if total_students > 0 else 0
        avg_score = round(sum(scores) / total_students, 1) if total_students > 0 else 0
        
        # 计算学习积极性 - 使用新的权重分配和计算方法
        engagement_score_total = sum(
            float(result.student_record.course_interaction_score) * 0.35 +
            float(result.student_record.video_watch_rate) * 100 * 0.25 +
            (float(result.student_record.homework_completion_rate) * 100 * 0.6 +
            (float(result.student_record.homework_completion_count) / 20) * 100 * 0.4) * 0.25 +
            (float(result.student_record.test_completion_rate) * 100 * 0.7 +
            (float(result.student_record.test_completion_count) / 10) * 100 * 0.3) * 0.15
            for result in cluster_results
        )
        engagement_score = round(engagement_score_total / total_students, 1) if total_students > 0 else 0
        
        # 计算平均能力分数 - 确保使用 result.student_record
        avg_scores = {
            'knowledge': round(sum(float(result.knowledge_dimension_score) for result in cluster_results) / total_students, 1) if total_students > 0 else 0,
            'attitude': round(sum(float(result.attitude_dimension_score) for result in cluster_results) / total_students, 1) if total_students > 0 else 0,
            'interest': round(sum(float(result.interest_dimension_score) for result in cluster_results) / total_students, 1) if total_students > 0 else 0,
            'homework': round(sum(float(result.student_record.homework_score) for result in cluster_results) / total_students, 1) if total_students > 0 else 0,
            'participation': round(sum(float(result.student_record.course_interaction_score) for result in cluster_results) / total_students, 1) if total_students > 0 else 0,
        }
        
        # 计算优秀学生的平均能力分数 - 确保使用 result.student_record
        excellent_results = [result for result in cluster_results if float(result.final_score) >= 90]
        # excellent_count 变量已在前面计算过
        if excellent_count > 0:
            excellent_scores = {
                'knowledge': round(sum(float(result.knowledge_dimension_score) for result in excellent_results) / excellent_count, 1),
                'attitude': round(sum(float(result.attitude_dimension_score) for result in excellent_results) / excellent_count, 1),
                'interest': round(sum(float(result.interest_dimension_score) for result in excellent_results) / excellent_count, 1),
                'homework': round(sum(float(result.student_record.homework_score) for result in excellent_results) / excellent_count, 1),
                'participation': round(sum(float(result.student_record.course_interaction_score) for result in excellent_results) / excellent_count, 1),
            }
        else:
            excellent_scores = {k: 0 for k in ['knowledge', 'attitude', 'interest', 'homework', 'participation']}
        
        # 准备散点图数据 - 确保使用 result.student_record
        scatter_data = []
        print("\n=== 学生评分数据 ===")
        try:
            for result in cluster_results:
                try:
                    score = float(result.final_score)
                    knowledge_score = round(float(result.knowledge_dimension_score), 1)
                    attitude_score = round(float(result.attitude_dimension_score), 1)
                    
                    if score >= 90: rating_index = 0
                    elif score >= 70: rating_index = 1
                    elif score >= 50: rating_index = 2
                    else: rating_index = 3
                    
                    # Accessing user_id via student_record -> user
                    student_identifier = result.student_record.user.id 

                    if not (0 <= knowledge_score <= 100 and 0 <= attitude_score <= 100):
                        print(f"警告：数据超出范围 - 学生ID: {student_identifier}, 知识维度: {knowledge_score}, 态度维度: {attitude_score}")
                        continue
                        
                    data_point = [
                        knowledge_score,
                        attitude_score,
                        ['优秀', '良好', '中等', '待提高'][rating_index],
                        rating_index,
                        student_identifier # 添加学生ID用于tooltip
                    ]
                    scatter_data.append(data_point)
                except Exception as e:
                    print(f"处理学生数据时出错 - 学生ID: {result.student_record.user.id if result.student_record and result.student_record.user else '未知'}, 错误: {str(e)}")
                    continue
            
            print("\n=== 散点图数据统计 ===")
            print(f"数据点总数: {len(scatter_data)}")
            print(f"优秀学生数量: {excellent_count}")
            print(f"各评级数量统计:")
            rating_counts = {
                '优秀': len([p for p in scatter_data if p[3] == 0]),
                '良好': len([p for p in scatter_data if p[3] == 1]),
                '中等': len([p for p in scatter_data if p[3] == 2]),
                '待提高': len([p for p in scatter_data if p[3] == 3])
            }
            for rating, count in rating_counts.items():
                print(f"{rating}: {count}人")
            
            if excellent_count > 0 and rating_counts['优秀'] == 0:
                print("\n警告：存在评分为优秀但未在散点图显示的学生")
                
        except Exception as e:
            print(f"生成散点图数据时出错: {str(e)}")
            scatter_data = []
        
        # 1. 学习表现分布柱状图数据
        performance_distribution_data = {
            'categories': ['优秀', '良好', '中等', '待提高'],
            'values': [excellent_count, good_count, average_count, poor_count]
        }

        # 2. 班级多维度能力对比图 (分组柱状图) 数据
        multi_dimension_comparison_data = {
            'categories': ['知识技能', '学习态度', '课程兴趣'],
            'series': [
                {
                    'name': '班级平均',
                    'type': 'bar',
                    'data': [
                        avg_scores['knowledge'],
                        avg_scores['attitude'],
                        avg_scores['interest']
                    ]
                },
                {
                    'name': '优秀学生平均',
                    'type': 'bar',
                    'data': [
                        excellent_scores['knowledge'],
                        excellent_scores['attitude'],
                        excellent_scores['interest']
                    ]
                }
            ]
        }
        
        # 3. 生成行动建议
        actionable_insights = []
        if total_students > 0:
            if (poor_count / total_students) >= 0.20: # 待提高学生超过20%
                actionable_insights.append({
                    "type": "warning",
                    "text": f"关注：待提高学生占比 ({poor_count/total_students:.1%}) 较高。建议加强对这部分学生的个性化辅导和学习资源支持。"
                })
            if avg_scores['attitude'] < 70:
                actionable_insights.append({
                    "type": "info",
                    "text": f"提升：班级整体学习态度平均分 ({avg_scores['attitude']:.1f}分) 有提升空间。可考虑组织学习经验分享会，或引入更多互动教学环节以提升学习积极性。"
                })
            if avg_scores['interest'] < 70:
                 actionable_insights.append({
                    "type": "info",
                    "text": f"探索：班级整体课程兴趣平均分 ({avg_scores['interest']:.1f}分) 不高。建议尝试引入更多实际案例、项目式学习或多样化的教学手段，以增强课程的吸引力和实用性。"
                })

            knowledge_gap = excellent_scores['knowledge'] - avg_scores['knowledge']
            if knowledge_gap > 10 and excellent_scores['knowledge'] > 0 : # 知识技能差距超过10分
                 actionable_insights.append({
                    "type": "info",
                    "text": f"借鉴：优秀学生在知识技能方面 ({excellent_scores['knowledge']:.1f}分) 显著领先班级平均 ({avg_scores['knowledge']:.1f}分)。可以总结并推广优秀学生的学习方法与策略。"
                })
        if not actionable_insights:
            actionable_insights.append({
                "type": "success",
                "text": "整体表现良好，各项关键指标均在合理范围内。请继续保持并关注个体差异。"
            })

        # 获取最近一次模型训练记录
        latest_model = ModelLog.objects.order_by('-train_time').first()
        
        # 准备上下文数据
        context = {
            'cluster_stats': {
                'total_students': total_students,
            },
            'latest_model': latest_model,
            'excellent_count': excellent_count,
            'good_count': good_count,
            'average_count': average_count,
            'poor_count': poor_count,
            'excellent_rate': excellent_rate,
            'avg_score': avg_score,
            'engagement_score': engagement_score, # 整体积极性得分
            
            # 班级平均能力分数 (用于卡片展示)
            'avg_knowledge_score': avg_scores['knowledge'],
            'avg_attitude_score': avg_scores['attitude'],
            'avg_interest_score': avg_scores['interest'], # 已修正为 interest_dimension_score
            'avg_homework_score': avg_scores['homework'], # 作业表现
            'avg_participation_score': avg_scores['participation'], # 课堂参与表现

            # 优秀学生能力分数 (可能用于其他地方，或未来扩展)
            'excellent_knowledge_score': excellent_scores['knowledge'],
            'excellent_attitude_score': excellent_scores['attitude'],
            'excellent_interest_score': excellent_scores['interest'], # 已修正
            'excellent_homework_score': excellent_scores['homework'],
            'excellent_participation_score': excellent_scores['participation'],
            
            'scatter_data': scatter_data, # 知识-态度散点图数据
            'performance_distribution_data': performance_distribution_data, # 学习表现分布柱状图数据
            'multi_dimension_comparison_data': multi_dimension_comparison_data, # 多维度能力对比分组柱状图数据
            'actionable_insights': actionable_insights # 行动建议
        }
        
        return render(request, 'cluster_analysis.html', context)
        
    except Exception as e:
        logger.error(f"聚类分析视图发生错误: {str(e)}", exc_info=True) # 添加日志记录
        messages.error(request, f'分析数据时发生错误: {str(e)}')
        return render(request, 'cluster_analysis.html', {'cluster_stats': {'total_students': 0}})

@staff_member_required
def run_cluster_analysis(request):
    """手动触发聚类分析"""
    try:
        # 获取学生记录数量，并进行基本验证
        record_count = StudentRecord.objects.count()
        if record_count == 0:
            messages.warning(request, '系统中没有学生记录数据，请先添加学习行为记录。')
            return redirect('profile_app:data_input')
        
        # 记录开始分析的日志
        logger.info(f"管理员 {request.user.username} 开始执行聚类分析，当前共有 {record_count} 条学生记录")
        
        # 创建分析器并执行更新
        analyzer = LearnerProfileAnalyzer()
        success = analyzer.update_model()
        
        if success:
            # 获取生成的画像数量
            profile_count = ClusterResult.objects.count()
            messages.success(request, f'聚类分析成功完成！共分析 {record_count} 条记录，生成 {profile_count} 个学习画像。')
            logger.info(f"聚类分析成功，生成 {profile_count} 个学习画像")
        else:
            messages.warning(request, '聚类分析过程中发生错误，请查看系统日志以获取详细信息。可能的原因：数据量不足、数据结构不满足聚类条件、或存在异常值。')
            logger.warning("聚类分析返回失败状态")
    except InsufficientDataError as e:
        logger.error(f"聚类分析数据不足错误: {str(e)}")
        messages.error(request, f'聚类分析失败: 数据不足 - {str(e)}')
    except DataAnalysisError as e:
        logger.error(f"聚类分析数据处理错误: {str(e)}")
        messages.error(request, f'聚类分析失败: 数据处理错误 - {str(e)}')
    except Exception as e:
        logger.error(f"聚类分析失败，未处理的异常: {str(e)}", exc_info=True)
        messages.error(request, f'聚类分析失败: {str(e)}')
    
    # 返回原页面或默认重定向到管理员仪表盘
    referer = request.META.get('HTTP_REFERER')
    if referer and '/admin/dashboard/' in referer:
        return redirect('admin_dashboard')
    else:
        return redirect('profile_app:index')

@staff_member_required # 保持权限一致性
def edit_student_record_view(request, record_id):
    record = get_object_or_404(StudentRecord, id=record_id)
    if request.method == 'POST':
        form = StudentRecordEditForm(request.POST, instance=record)
        if form.is_valid():
            updated_record = form.save()
            # 重新获取完整的记录信息，包括用户资料
            updated_record.refresh_from_db()
            student_name = updated_record.user.userprofile.name if hasattr(updated_record.user, 'userprofile') and updated_record.user.userprofile.name else updated_record.user.username
            messages.success(request, f"学生 {student_name} 的记录已更新。请重新运行聚类分析")
            return redirect('profile_app:index')
        else:
            messages.error(request, "表单数据无效，请检查错误。")
    else:
        form = StudentRecordEditForm(instance=record)
    
    context = {
        'form': form,
        'record': record,
        'student_name': record.user.userprofile.name if hasattr(record.user, 'userprofile') and record.user.userprofile.name else record.user.username
    }
    return render(request, 'edit_student_record.html', context)

@staff_member_required
def delete_student_record_view(request, record_id):
    record = get_object_or_404(StudentRecord, id=record_id)
    user_identifier = record.user.userprofile.name if hasattr(record.user, 'userprofile') and record.user.userprofile.name else record.user.username
    
    if request.method == 'POST':
        try:
            user_to_potentially_delete = record.user # Store user before record is deleted
            record.delete()
            message_text = f"学生 {user_identifier} (记录ID: {record_id}) 的学习记录已成功删除。"
            
            delete_user_too = request.POST.get('delete_user_too')
            if delete_user_too:
                try:
                    user_to_potentially_delete.delete()
                    message_text += f" 同时，用户账户 {user_identifier} 也已成功删除。"
                    messages.success(request, message_text)
                except Exception as e_user_delete:
                    logger.error(f"删除学习记录后，删除用户时出错 (User ID: {user_to_potentially_delete.id}): {str(e_user_delete)}", exc_info=True)
                    messages.warning(request, message_text + f" 但删除用户账户 {user_identifier} 时发生错误: {str(e_user_delete)}")
            else:
                messages.success(request, message_text)
                
            return redirect('profile_app:index')
        except Exception as e:
            logger.error(f"删除学生记录时出错 (ID: {record_id}): {str(e)}", exc_info=True)
            messages.error(request, f"删除记录时发生错误: {str(e)}")
            return redirect('profile_app:index') 
            
    # Handle GET request: Redirect to index as the confirmation page is considered redundant.
    messages.info(request, "请通过学生列表中的操作按钮执行删除。")
    return redirect('profile_app:index')

@staff_member_required
def export_csv(request):
    # 创建响应对象，指定内容类型为CSV
    response = HttpResponse(content_type='text/csv')
    response['Content-Disposition'] = 'attachment; filename="student_records.csv"'
    
    # 创建CSV写入器
    writer = csv.writer(response)
    
    # 写入表头
    writer.writerow(['学号', '姓名', '用户名', '性别', '作业成绩', '出勤得分', '互动得分', 
                    '作业完成率(%)', '测验完成率(%)', '视频观看率(%)', '实训通过率(%)', 
                    '作业完成次数', '测验完成次数', '综合表现'])
    
    # 直接获取所有学生记录及关联数据
    records = StudentRecord.objects.select_related(
        'user__userprofile',
        'cluster_result'
    ).order_by('user__userprofile__name', 'user__username')
    
    # 写入数据行
    for record in records:
        user = record.user
        profile = user.userprofile if hasattr(user, 'userprofile') else None
        cluster_result = record.cluster_result if hasattr(record, 'cluster_result') else None
        
        writer.writerow([
            profile.student_id if profile and profile.student_id else '',
            profile.name if profile and profile.name else user.username,
            user.username,
            profile.get_gender_display() if profile else '',
            record.homework_score,
            record.sign_in_score,
            record.course_interaction_score,
            record.homework_completion_rate,  # 修正字段名
            record.test_completion_rate,      # 修正字段名
            record.video_watch_rate,          # 修正字段名
            record.training_pass_rate,        # 修正字段名
            record.homework_completion_count,
            record.test_completion_count,
            cluster_result.final_score if cluster_result else ''
        ])
    
    return response

@staff_member_required
def no_student_record_notice_view(request, user_id):
    user = get_object_or_404(User, pk=user_id)
    student_name = user.username # Default to username
    if hasattr(user, 'userprofile') and user.userprofile.name:
        student_name = user.userprofile.name
    
    context = {
        'student_name': student_name,
        'username': user.username,
        'user_id': user_id
    }
    return render(request, 'no_record_notice.html', context)

@staff_member_required
def delete_user_view(request, user_id):
    user_to_delete = get_object_or_404(User, pk=user_id)
    user_identifier = user_to_delete.userprofile.name if hasattr(user_to_delete, 'userprofile') and user_to_delete.userprofile.name else user_to_delete.username
    
    if request.method == 'POST':
        try:
            # Deleting the User object will also delete the related UserProfile due to on_delete=models.CASCADE by default on OneToOneFields.
            # Also, any StudentRecord objects linked to this user will be deleted if StudentRecord.user has on_delete=models.CASCADE.
            user_to_delete.delete()
            messages.success(request, f"学生用户 {user_identifier} (ID: {user_id}) 已成功删除。")
            return redirect('profile_app:index')
        except Exception as e:
            logger.error(f"删除用户时出错 (ID: {user_id}): {str(e)}", exc_info=True)
            messages.error(request, f"删除用户 {user_identifier} 时发生错误: {str(e)}")
            return redirect('profile_app:index')
            
    # If GET request, it's usually handled by a confirmation modal on the frontend
    # or a separate confirmation page. For now, direct POST is assumed from modal.
    # For a GET request leading to a confirmation page, you would render a template here.
    # return render(request, 'profile_app/confirm_delete_user.html', {'user_to_delete': user_to_delete})
    
    # Fallback redirect if accessed via GET without a specific confirmation page template
    # This shouldn't happen if the modal correctly POSTs.
    return redirect('profile_app:index') 