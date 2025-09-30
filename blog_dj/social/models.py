from django.db import models
from django.contrib.auth.models import User
from django.urls import reverse
from django.utils import timezone
import os

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    bio = models.TextField(max_length=500, blank=True, null=True)
    avatar_url = models.URLField(blank=True, null=True)
    avatar_image = models.ImageField(upload_to='avatars/', blank=True, null=True)
    birth_date = models.DateField(null=True, blank=True)
    location = models.CharField(max_length=100, blank=True, null=True)
    website = models.URLField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def get_avatar(self):
        if self.avatar_image:
            return self.avatar_image.url
        elif self.avatar_url:
            return self.avatar_url
        return 'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&w=400'

    def __str__(self):
        return f"{self.user.username}'s Profile"

class Tag(models.Model):
    name = models.CharField(max_length=50, unique=True)
    color = models.CharField(max_length=7, default='#007bff')
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name

class Post(models.Model):
    VISIBILITY_CHOICES = [
        ('public', 'Публичный'),
        ('private', 'Приватный'),
        ('request', 'По запросу'),
    ]

    author = models.ForeignKey(User, on_delete=models.CASCADE, related_name='posts')
    title = models.CharField(max_length=200)
    content = models.TextField()
    image_url = models.URLField(blank=True, null=True)
    image_file = models.ImageField(upload_to='posts/', blank=True, null=True)
    visibility = models.CharField(max_length=10, choices=VISIBILITY_CHOICES, default='public')
    tags = models.ManyToManyField(Tag, blank=True, related_name='posts')
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    likes = models.ManyToManyField(User, blank=True, related_name='liked_posts')

    class Meta:
        ordering = ['-created_at']

    def get_image(self):
        if self.image_file:
            return self.image_file.url
        elif self.image_url:
            return self.image_url
        return None

    def get_absolute_url(self):
        return reverse('post_detail', kwargs={'pk': self.pk})

    def total_likes(self):
        return self.likes.count()

    def __str__(self):
        return f"{self.title} - {self.author.username}"

class Follow(models.Model):
    follower = models.ForeignKey(User, on_delete=models.CASCADE, related_name='following')
    following = models.ForeignKey(User, on_delete=models.CASCADE, related_name='followers')
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('follower', 'following')

    def __str__(self):
        return f"{self.follower.username} follows {self.following.username}"

class Comment(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='comments')
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ['created_at']

    def __str__(self):
        return f"Comment by {self.author.username} on {self.post.title}"

class PostRequest(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='requests')
    requester = models.ForeignKey(User, on_delete=models.CASCADE)
    approved = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('post', 'requester')

    def __str__(self):
        return f"Request by {self.requester.username} for {self.post.title}"

# Сигналы для создания профиля
from django.db.models.signals import post_save
from django.dispatch import receiver

@receiver(post_save, sender=User)
def create_user_profile(sender, instance, created, **kwargs):
    if created:
        Profile.objects.create(user=instance)

@receiver(post_save, sender=User)
def save_user_profile(sender, instance, **kwargs):
    instance.profile.save()