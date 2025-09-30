from django.urls import path
from django.contrib.auth import views as auth_views
from . import views

urlpatterns = [
    # Главная страница
    path('', views.feed_view, name='feed'),
    
    # Аутентификация
    path('login/', auth_views.LoginView.as_view(template_name='registration/login.html'), name='login'),
    path('logout/', auth_views.LogoutView.as_view(), name='logout'),
    path('register/', views.register_view, name='register'),
    
    # Посты
    path('create/', views.create_post_view, name='create_post'),
    path('post/<int:pk>/', views.post_detail_view, name='post_detail'),
    path('post/<int:pk>/edit/', views.edit_post_view, name='edit_post'),
    path('post/<int:pk>/delete/', views.delete_post_view, name='delete_post'),
    path('post/<int:pk>/like/', views.like_post_view, name='like_post'),
    path('post/<int:pk>/request/', views.request_post_view, name='request_post'),
    
    # Комментарии
    path('post/<int:pk>/comment/', views.add_comment_view, name='add_comment'),
    path('comment/<int:pk>/delete/', views.delete_comment_view, name='delete_comment'),
    
    # Профиль и подписки
    path('profile/', views.profile_view, name='profile'),
    path('profile/edit/', views.edit_profile_view, name='edit_profile'),
    path('user/<str:username>/', views.user_profile_view, name='user_profile'),
    path('follow/<str:username>/', views.follow_user_view, name='follow_user'),
    path('unfollow/<str:username>/', views.unfollow_user_view, name='unfollow_user'),
    
    # Теги и поиск
    path('tag/<str:tag_name>/', views.posts_by_tag_view, name='posts_by_tag'),
    path('public/', views.public_posts_view, name='public_posts'),
    path('my-posts/', views.my_posts_view, name='my_posts'),
    
    # Запросы на просмотр приватных постов
    path('requests/', views.post_requests_view, name='post_requests'),
    path('request/<int:pk>/approve/', views.approve_request_view, name='approve_request'),
    path('request/<int:pk>/deny/', views.deny_request_view, name='deny_request'),
]