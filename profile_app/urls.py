from django.urls import path, include, reverse_lazy
from . import views
from .views import AdminSignUpView, AdminLoginView, AdminLogoutView, StudentSignUpView
from django.contrib.auth import views as auth_views
from .autocompletes import UserStudentAutocomplete

app_name = 'profile_app'

urlpatterns = [
    path('', views.index, name='index'),
    # path('admin/dashboard/', views.admin_dashboard, name='admin_dashboard'), # 此行已移至项目级urls.py
    path('user-student-autocomplete/', UserStudentAutocomplete.as_view(), name='user-student-autocomplete'),
    path('input/', views.data_input, name='data_input'),
    path('radar/<int:record_id>/', views.radar_chart, name='radar_chart'),
    path('cluster-analysis/', views.cluster_analysis, name='cluster_analysis'),
    path('run-cluster-analysis/', views.run_cluster_analysis, name='run_cluster_analysis'),
    path('admin/signup/', AdminSignUpView.as_view(), name='signup'),
    path('login/', AdminLoginView.as_view(), name='login'),
    path('logout/', AdminLogoutView.as_view(), name='logout'),
    path('student/signup/', StudentSignUpView.as_view(), name='student_signup'),
    path('student/dashboard/', views.student_dashboard_view, name='student_dashboard'),
    path('student/<int:record_id>/edit/', views.edit_student_record_view, name='edit_student_record'),
    path('student/<int:record_id>/delete/', views.delete_student_record_view, name='delete_student_record'),
    path('notice/no_record/<int:user_id>/', views.no_student_record_notice_view, name='no_student_record_notice'),
    path('user/<int:user_id>/delete/', views.delete_user_view, name='delete_user'),
    
    # Explicitly define password change URLs to ensure correct success_url resolution
    path('auth/password_change/', 
         auth_views.PasswordChangeView.as_view(
             template_name='auth/password_change_form.html',
             success_url=reverse_lazy('profile_app:password_change_done')
         ),
         name='password_change'),
    path('auth/password_change/done/', 
         auth_views.PasswordChangeDoneView.as_view(
             template_name='auth/password_change_done.html'
         ),
         name='password_change_done'),

    # For other auth URLs, we can still use include if they don't cause issues,
    # or define them explicitly as well.
    # path('auth/', include('django.contrib.auth.urls')), # Remove or comment out this line
    # If you need password reset, etc., you'll need to add them similarly or use include
    # carefully. For now, let's only define what's needed for password_change.
    # For a more complete set from django.contrib.auth.urls, you'd add:
    # path('auth/login/', auth_views.LoginView.as_view(template_name='registration/login.html'), name='login'),
    # path('auth/logout/', auth_views.LogoutView.as_view(), name='logout'), # next_page can be set in settings or here
    path('auth/password_reset/', 
         auth_views.PasswordResetView.as_view(
            template_name='registration/password_reset_form.html',
            email_template_name='registration/password_reset_email.html',
            subject_template_name='registration/password_reset_subject.txt',
            success_url=reverse_lazy('profile_app:password_reset_done')
         ),
         name='password_reset'),
    path('auth/password_reset/done/', 
         auth_views.PasswordResetDoneView.as_view(
            template_name='registration/password_reset_done.html'
         ),
         name='password_reset_done'),
    path('auth/reset/<uidb64>/<token>/', 
         auth_views.PasswordResetConfirmView.as_view(
            template_name='registration/password_reset_confirm.html',
            success_url=reverse_lazy('profile_app:password_reset_complete')
         ),
         name='password_reset_confirm'),
    path('auth/reset/done/', 
         auth_views.PasswordResetCompleteView.as_view(
            template_name='registration/password_reset_complete.html'
         ),
         name='password_reset_complete'),
    path('export-csv/', views.export_csv, name='export_csv'),
]