from django.urls import path
from . import views

app_name = 'backend'

urlpatterns = [
    path('home/', views.home, name='home'),  # 明確定義為 home/
    path('products/', views.product_list, name='product_list'),
    path('contact/', views.contact, name='contact'),
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('dashboard/', views.admin_dashboard, name='admin_dashboard'),
    path('manage_products/', views.manage_products, name='manage_products'),
]