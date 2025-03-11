from django.urls import path
from . import views

app_name = 'backend'

urlpatterns = [
    path('home/', views.home, name='home'),
    path('products/', views.product_list, name='product_list'),
    path('contact/', views.contact, name='contact'),
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('dashboard/', views.dashboard, name='dashboard'),
    path('manage_products/', views.manage_products, name='manage_products'),
    path('manage_categories/', views.manage_categories, name='manage_categories'),
    path('manage_employees/', views.manage_employees, name='manage_employees'),
    path('manage_homepage/', views.manage_homepage, name='manage_homepage'),
]