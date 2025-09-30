from django import forms
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User
from .models import Post, Comment, Profile, Tag

class CustomUserCreationForm(UserCreationForm):
    email = forms.EmailField(required=True, widget=forms.EmailInput(attrs={'class': 'form-control'}))
    first_name = forms.CharField(required=True, widget=forms.TextInput(attrs={'class': 'form-control'}))
    last_name = forms.CharField(required=True, widget=forms.TextInput(attrs={'class': 'form-control'}))

    class Meta:
        model = User
        fields = ('username', 'first_name', 'last_name', 'email', 'password1', 'password2')
        widgets = {
            'username': forms.TextInput(attrs={'class': 'form-control'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.fields['password1'].widget.attrs.update({'class': 'form-control'})
        self.fields['password2'].widget.attrs.update({'class': 'form-control'})

    def save(self, commit=True):
        user = super().save(commit=False)
        user.email = self.cleaned_data['email']
        user.first_name = self.cleaned_data['first_name']
        user.last_name = self.cleaned_data['last_name']
        if commit:
            user.save()
        return user

class PostForm(forms.ModelForm):
    tags = forms.CharField(
        required=False,
        widget=forms.TextInput(attrs={
            'class': 'form-control',
            'placeholder': 'Введите теги через запятую (например: технологии, программирование, django)'
        }),
        help_text='Введите теги через запятую'
    )

    class Meta:
        model = Post
        fields = ['title', 'content', 'image_url', 'image_file', 'visibility']
        widgets = {
            'title': forms.TextInput(attrs={'class': 'form-control'}),
            'content': forms.Textarea(attrs={'class': 'form-control', 'rows': 10}),
            'image_url': forms.URLInput(attrs={'class': 'form-control', 'placeholder': 'https://example.com/image.jpg'}),
            'image_file': forms.FileInput(attrs={'class': 'form-control'}),
            'visibility': forms.Select(attrs={'class': 'form-control'}),
        }

    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)
        if self.instance.pk:
            # Предзаполнение тегов при редактировании
            tags = self.instance.tags.all()
            if tags:
                self.fields['tags'].initial = ', '.join([tag.name for tag in tags])

    def save(self, commit=True):
        instance = super().save(commit)
        if commit:
            self.save_tags(instance)
        return instance

    def save_tags(self, post):
        # Удаляем старые теги
        post.tags.clear()
        
        # Добавляем новые теги
        tags_input = self.cleaned_data.get('tags', '')
        if tags_input:
            tag_names = [tag.strip() for tag in tags_input.split(',') if tag.strip()]
            for tag_name in tag_names:
                tag, created = Tag.objects.get_or_create(name=tag_name.lower())
                post.tags.add(tag)

class CommentForm(forms.ModelForm):
    class Meta:
        model = Comment
        fields = ['content']
        widgets = {
            'content': forms.Textarea(attrs={
                'class': 'form-control',
                'rows': 3,
                'placeholder': 'Написать комментарий...'
            }),
        }

class ProfileForm(forms.ModelForm):
    class Meta:
        model = Profile
        fields = ['bio', 'avatar_url', 'avatar_image', 'birth_date', 'location', 'website']
        widgets = {
            'bio': forms.Textarea(attrs={'class': 'form-control', 'rows': 4}),
            'avatar_url': forms.URLInput(attrs={'class': 'form-control', 'placeholder': 'https://example.com/avatar.jpg'}),
            'avatar_image': forms.FileInput(attrs={'class': 'form-control'}),
            'birth_date': forms.DateInput(attrs={'class': 'form-control', 'type': 'date'}),
            'location': forms.TextInput(attrs={'class': 'form-control'}),
            'website': forms.URLInput(attrs={'class': 'form-control', 'placeholder': 'https://example.com'}),
        }