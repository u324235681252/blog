document.addEventListener('DOMContentLoaded', function() {
    // CSRF токен для AJAX запросов
    function getCookie(name) {
        let cookieValue = null;
        if (document.cookie && document.cookie !== '') {
            const cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();
                if (cookie.substring(0, name.length + 1) === (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }
    
    const csrftoken = getCookie('csrftoken');

    // Лайки постов
    const likeButtons = document.querySelectorAll('.like-btn');
    likeButtons.forEach(button => {
        button.addEventListener('click', function() {
            const postId = this.getAttribute('data-post-id');
            
            fetch(`/post/${postId}/like/`, {
                method: 'POST',
                headers: {
                    'X-CSRFToken': csrftoken,
                    'Content-Type': 'application/json',
                },
            })
            .then(response => response.json())
            .then(data => {
                const icon = this.querySelector('i');
                const countSpan = this.querySelector('.like-count');
                
                if (data.liked) {
                    icon.classList.remove('bi-heart');
                    icon.classList.add('bi-heart-fill');
                    this.classList.add('liked');
                } else {
                    icon.classList.remove('bi-heart-fill');
                    icon.classList.add('bi-heart');
                    this.classList.remove('liked');
                }
                
                countSpan.textContent = data.total_likes;
                
                // Анимация
                this.style.transform = 'scale(1.2)';
                setTimeout(() => {
                    this.style.transform = 'scale(1)';
                }, 150);
            })
            .catch(error => {
                console.error('Ошибка:', error);
            });
        });
    });

    // Предварительный просмотр изображений
    const imageInputs = document.querySelectorAll('input[type="file"][accept*="image"]');
    imageInputs.forEach(input => {
        input.addEventListener('change', function() {
            const file = this.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    // Создаем или обновляем превью
                    let preview = document.getElementById('image-preview');
                    if (!preview) {
                        preview = document.createElement('div');
                        preview.id = 'image-preview';
                        preview.className = 'mt-3';
                        input.parentNode.appendChild(preview);
                    }
                    
                    preview.innerHTML = `
                        <div class="card" style="max-width: 300px;">
                            <img src="${e.target.result}" class="card-img-top" alt="Превью">
                            <div class="card-body">
                                <small class="text-muted">Превью изображения</small>
                            </div>
                        </div>
                    `;
                };
                reader.readAsDataURL(file);
            }
        });
    });

    // Автоматическое изменение размера textarea
    const textareas = document.querySelectorAll('textarea');
    textareas.forEach(textarea => {
        textarea.style.height = 'auto';
        textarea.style.height = textarea.scrollHeight + 'px';
        
        textarea.addEventListener('input', function() {
            this.style.height = 'auto';
            this.style.height = this.scrollHeight + 'px';
        });
    });

    // Плавная анимация появления карточек
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
                observer.unobserve(entry.target);
            }
        });
    }, observerOptions);

    // Применяем анимацию к карточкам постов
    const cards = document.querySelectorAll('.card');
    cards.forEach((card, index) => {
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
        card.style.transitionDelay = `${index * 0.1}s`;
        observer.observe(card);
    });

    // Подтверждение удаления
    const deleteButtons = document.querySelectorAll('[data-action="delete"]');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            if (!confirm('Вы уверены, что хотите удалить?')) {
                e.preventDefault();
            }
        });
    });

    // Уведомления
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
        setTimeout(() => {
            alert.style.opacity = '0';
            alert.style.transform = 'translateY(-100%)';
            setTimeout(() => {
                alert.remove();
            }, 300);
        }, 5000);
    });

    // Кнопка "Наверх"
    const scrollToTopBtn = document.createElement('button');
    scrollToTopBtn.innerHTML = '<i class="bi bi-arrow-up"></i>';
    scrollToTopBtn.className = 'btn btn-primary rounded-circle position-fixed';
    scrollToTopBtn.style.cssText = `
        bottom: 20px;
        right: 20px;
        z-index: 1000;
        width: 50px;
        height: 50px;
        display: none;
        box-shadow: 0 4px 8px rgba(0,0,0,0.2);
    `;
    document.body.appendChild(scrollToTopBtn);

    window.addEventListener('scroll', function() {
        if (window.pageYOffset > 300) {
            scrollToTopBtn.style.display = 'block';
        } else {
            scrollToTopBtn.style.display = 'none';
        }
    });

    scrollToTopBtn.addEventListener('click', function() {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
});