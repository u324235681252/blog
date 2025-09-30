from django.contrib import admin
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
from .models import Profile, Post, Follow, Comment, Tag, PostRequest

class ProfileInline(admin.StackedInline):
    model = Profile
    can_delete = False
    verbose_name_plural = 'Профили'

class UserAdmin(UserAdmin):
    inlines = (ProfileInline,)

@admin.register(Post)
class PostAdmin(admin.ModelAdmin):
    list_display = ('title', 'author', 'visibility', 'created_at', 'total_likes')
    list_filter = ('visibility', 'created_at', 'tags')
    search_fields = ('title', 'content', 'author__username')
    filter_horizontal = ('tags', 'likes')

@admin.register(Tag)
class TagAdmin(admin.ModelAdmin):
    list_display = ('name', 'color', 'created_at')
    search_fields = ('name',)

@admin.register(Follow)
class FollowAdmin(admin.ModelAdmin):
    list_display = ('follower', 'following', 'created_at')
    list_filter = ('created_at',)

@admin.register(Comment)
class CommentAdmin(admin.ModelAdmin):
    list_display = ('post', 'author', 'created_at')
    list_filter = ('created_at',)
    search_fields = ('content', 'author__username')

@admin.register(PostRequest)
class PostRequestAdmin(admin.ModelAdmin):
    list_display = ('post', 'requester', 'approved', 'created_at')
    list_filter = ('approved', 'created_at')

admin.site.unregister(User)
admin.site.register(User, UserAdmin)