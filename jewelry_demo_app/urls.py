from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('products/', views.product_list, name='product_list'),
    path('contact/', views.contact, name='contact'), 
    path('login/', views.login_view, name='login'),  
]