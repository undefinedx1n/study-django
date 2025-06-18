from django.contrib import admin
from django.urls import path, include
from profile_app import views as profile_app_views # 导入profile_app的视图

urlpatterns = [
    # 自定义的管理员仪表盘URL，置于Django内置admin之前以确保优先匹配
    path('admin/dashboard/', profile_app_views.admin_dashboard, name='admin_dashboard'),
    
    path('admin/', admin.site.urls), # Django内置admin的URL
    
    # 下面这行被注释掉，以解决 'profile_app' 命名空间冲突问题
    # path('profile/', include('profile_app.urls', namespace='profile_app')),

    # profile_app 的 URL 现在从根路径开始，
    # 并使用在 profile_app/urls.py 中定义的 app_name='profile_app' 作为命名空间。
    # 这样 profile_app:index 就可以通过 / 访问。
    path('', include('profile_app.urls')),
]

                                 