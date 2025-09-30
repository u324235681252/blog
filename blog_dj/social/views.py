from django.shortcuts import render, get_object_or_404, redirect
from django.contrib.auth import login
from django.contrib.auth.decorators import login_required
from django.contrib.auth.models import User
from django.contrib import messages
from django.db.models import Q, Count
from django.http import JsonResponse
from django.views.decorators.http import require_POST
from django.core.paginator import Paginator
from .models import Post, Profile, Follow, Comment, Tag, PostRequest
from .forms import CustomUserCreationForm, PostForm, CommentForm, ProfileForm
import json

def register_view(request):
    if request.method == 'POST':
        form = CustomUserCreationForm(request.POST)
        if form.is_valid():
            user = form.save()
            login(request, user)
            messages.success(request, 'Регистрация прошла успешно!')
            return redirect('feed')
    else:
        form = CustomUserCreationForm()
    return render(request, 'registration/register.html', {'form': form})

@login_required
def feed_view(request):
    # Посты от пользователей, на которых подписан текущий пользователь
    following_users = Follow.objects.filter(follower=request.user).values_list('following', flat=True)
    
    # Включаем собственные посты пользователя
    posts = Post.objects.filter(
        Q(author__in=following_users) | Q(author=request.user)
    ).filter(
        Q(visibility='public') | 
        Q(visibility='private', author=request.user) |
        Q(visibility='request', author=request.user) |
        Q(visibility='request', requests__requester=request.user, requests__approved=True)
    ).distinct().select_related('author', 'author__profile').prefetch_related('tags', 'comments', 'likes')
    
    # Пагинация
    paginator = Paginator(posts, 10)
    page_number = request.GET.get('page')
    page_posts = paginator.get_page(page_number)
    
    # Популярные теги
    popular_tags = Tag.objects.annotate(post_count=Count('posts')).order_by('-post_count')[:10]
    
    context = {
        'posts': page_posts,
        'popular_tags': popular_tags,
    }
    return render(request, 'social/feed.html', context)

@login_required
def create_post_view(request):
    if request.method == 'POST':
        form = PostForm(request.POST, request.FILES)
        if form.is_valid():
            post = form.save(commit=False)
            post.author = request.user
            post.save()
            form.save_m2m()  # Сохраняем теги
            messages.success(request, 'Пост успешно создан!')
            return redirect('post_detail', pk=post.pk)
    else:
        form = PostForm()
    return render(request, 'social/create_post.html', {'form': form})

def post_detail_view(request, pk):
    post = get_object_or_404(Post, pk=pk)
    
    # Проверка доступа к посту
    can_view = False
    if post.visibility == 'public':
        can_view = True
    elif request.user.is_authenticated:
        if post.author == request.user:
            can_view = True
        elif post.visibility == 'request':
            # Проверяем, есть ли одобренный запрос
            approved_request = PostRequest.objects.filter(
                post=post, requester=request.user, approved=True
            ).exists()
            can_view = approved_request
    
    if not can_view and request.user.is_authenticated and post.visibility == 'request':
        # Показываем форму запроса доступа
        existing_request = PostRequest.objects.filter(post=post, requester=request.user).first()
        return render(request, 'social/request_access.html', {
            'post': post,
            'existing_request': existing_request
        })
    elif not can_view:
        messages.error(request, 'У вас нет доступа к этому посту.')
        return redirect('feed')
    
    comments = Comment.objects.filter(post=post).select_related('author', 'author__profile')
    comment_form = CommentForm() if request.user.is_authenticated else None
    
    context = {
        'post': post,
        'comments': comments,
        'comment_form': comment_form,
    }
    return render(request, 'social/post_detail.html', context)

@login_required
def edit_post_view(request, pk):
    post = get_object_or_404(Post, pk=pk, author=request.user)
    
    if request.method == 'POST':
        form = PostForm(request.POST, request.FILES, instance=post)
        if form.is_valid():
            form.save()
            messages.success(request, 'Пост успешно обновлен!')
            return redirect('post_detail', pk=post.pk)
    else:
        form = PostForm(instance=post)
    
    return render(request, 'social/edit_post.html', {'form': form, 'post': post})

@login_required
def delete_post_view(request, pk):
    post = get_object_or_404(Post, pk=pk, author=request.user)
    
    if request.method == 'POST':
        post.delete()
        messages.success(request, 'Пост успешно удален!')
        return redirect('my_posts')
    
    return render(request, 'social/delete_post.html', {'post': post})

@login_required
@require_POST
def like_post_view(request, pk):
    post = get_object_or_404(Post, pk=pk)
    
    if request.user in post.likes.all():
        post.likes.remove(request.user)
        liked = False
    else:
        post.likes.add(request.user)
        liked = True
    
    return JsonResponse({
        'liked': liked,
        'total_likes': post.total_likes()
    })

@login_required
def add_comment_view(request, pk):
    post = get_object_or_404(Post, pk=pk)
    
    if request.method == 'POST':
        form = CommentForm(request.POST)
        if form.is_valid():
            comment = form.save(commit=False)
            comment.post = post
            comment.author = request.user
            comment.save()
            messages.success(request, 'Комментарий добавлен!')
        return redirect('post_detail', pk=pk)

@login_required
def delete_comment_view(request, pk):
    comment = get_object_or_404(Comment, pk=pk)
    
    if request.user == comment.author or request.user == comment.post.author:
        post_pk = comment.post.pk
        comment.delete()
        messages.success(request, 'Комментарий удален!')
        return redirect('post_detail', pk=post_pk)
    
    messages.error(request, 'У вас нет прав на удаление этого комментария.')
    return redirect('post_detail', pk=comment.post.pk)

@login_required
def profile_view(request):
    posts = Post.objects.filter(author=request.user).select_related('author__profile').prefetch_related('tags')
    following_count = Follow.objects.filter(follower=request.user).count()
    followers_count = Follow.objects.filter(following=request.user).count()
    
    context = {
        'user': request.user,
        'posts': posts,
        'following_count': following_count,
        'followers_count': followers_count,
    }
    return render(request, 'social/profile.html', context)

@login_required
def edit_profile_view(request):
    if request.method == 'POST':
        form = ProfileForm(request.POST, request.FILES, instance=request.user.profile)
        if form.is_valid():
            form.save()
            messages.success(request, 'Профиль успешно обновлен!')
            return redirect('profile')
    else:
        form = ProfileForm(instance=request.user.profile)
    
    return render(request, 'social/edit_profile.html', {'form': form})

def user_profile_view(request, username):
    user = get_object_or_404(User, username=username)
    posts = Post.objects.filter(author=user, visibility='public').select_related('author__profile').prefetch_related('tags')
    
    is_following = False
    if request.user.is_authenticated:
        is_following = Follow.objects.filter(follower=request.user, following=user).exists()
    
    following_count = Follow.objects.filter(follower=user).count()
    followers_count = Follow.objects.filter(following=user).count()
    
    context = {
        'profile_user': user,
        'posts': posts,
        'is_following': is_following,
        'following_count': following_count,
        'followers_count': followers_count,
    }
    return render(request, 'social/user_profile.html', context)

@login_required
def follow_user_view(request, username):
    user_to_follow = get_object_or_404(User, username=username)
    
    if user_to_follow != request.user:
        follow, created = Follow.objects.get_or_create(
            follower=request.user,
            following=user_to_follow
        )
        if created:
            messages.success(request, f'Вы подписались на {user_to_follow.username}!')
    
    return redirect('user_profile', username=username)

@login_required
def unfollow_user_view(request, username):
    user_to_unfollow = get_object_or_404(User, username=username)
    
    Follow.objects.filter(follower=request.user, following=user_to_unfollow).delete()
    messages.success(request, f'Вы отписались от {user_to_unfollow.username}!')
    
    return redirect('user_profile', username=username)

def posts_by_tag_view(request, tag_name):
    tag = get_object_or_404(Tag, name=tag_name)
    posts = Post.objects.filter(tags=tag, visibility='public').select_related('author', 'author__profile').prefetch_related('tags')
    
    paginator = Paginator(posts, 10)
    page_number = request.GET.get('page')
    page_posts = paginator.get_page(page_number)
    
    context = {
        'tag': tag,
        'posts': page_posts,
    }
    return render(request, 'social/posts_by_tag.html', context)

def public_posts_view(request):
    posts = Post.objects.filter(visibility='public').select_related('author', 'author__profile').prefetch_related('tags')
    
    paginator = Paginator(posts, 10)
    page_number = request.GET.get('page')
    page_posts = paginator.get_page(page_number)
    
    context = {
        'posts': page_posts,
    }
    return render(request, 'social/public_posts.html', context)

@login_required
def my_posts_view(request):
    posts = Post.objects.filter(author=request.user).select_related('author__profile').prefetch_related('tags')
    
    paginator = Paginator(posts, 10)
    page_number = request.GET.get('page')
    page_posts = paginator.get_page(page_number)
    
    context = {
        'posts': page_posts,
    }
    return render(request, 'social/my_posts.html', context)

@login_required
def request_post_view(request, pk):
    post = get_object_or_404(Post, pk=pk)
    
    if post.visibility != 'request':
        messages.error(request, 'Этот пост не требует запроса на доступ.')
        return redirect('post_detail', pk=pk)
    
    existing_request = PostRequest.objects.filter(post=post, requester=request.user).first()
    
    if existing_request:
        messages.info(request, 'Вы уже отправили запрос на доступ к этому посту.')
    else:
        PostRequest.objects.create(post=post, requester=request.user)
        messages.success(request, 'Запрос на доступ отправлен!')
    
    return redirect('post_detail', pk=pk)

@login_required
def post_requests_view(request):
    # Запросы на посты текущего пользователя
    requests = PostRequest.objects.filter(
        post__author=request.user
    ).select_related('requester', 'post').order_by('-created_at')
    
    context = {
        'requests': requests,
    }
    return render(request, 'social/post_requests.html', context)

@login_required
def approve_request_view(request, pk):
    post_request = get_object_or_404(PostRequest, pk=pk, post__author=request.user)
    post_request.approved = True
    post_request.save()
    
    messages.success(request, f'Запрос от {post_request.requester.username} одобрен!')
    return redirect('post_requests')

@login_required
def deny_request_view(request, pk):
    post_request = get_object_or_404(PostRequest, pk=pk, post__author=request.user)
    post_request.delete()
    
    messages.success(request, f'Запрос от {post_request.requester.username} отклонен!')
    return redirect('post_requests')