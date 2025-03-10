from django.contrib import admin
from django.urls import path, include
from jewelry_demo_app import views

urlpatterns = [
    path('admin/', admin.site.urls),
    path('backend/', include('jewelry_demo_app.urls', namespace='backend')),
    path('', views.home, name='home'),  # 根路徑映射到 home
]