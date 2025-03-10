from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth import logout
from django.contrib.auth.views import LoginView
from .models import CustomUser, Product
from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError

User = get_user_model()

def is_designer_or_admin(user):
    return user.level in ['designer', 'admin'] or user.is_sakamata199

def home(request):
    return render(request, 'jewelry_demo_app/index.html')

def product_list(request):
    products = Product.objects.all()
    context = {'products': products}
    return render(request, 'jewelry_demo_app/product_list.html', context)

def contact(request):
    return render(request, 'jewelry_demo_app/contact.html')

@login_required
@user_passes_test(is_designer_or_admin)
def admin_dashboard(request):
    products = Product.objects.all()
    employees = User.objects.filter(level__in=['admin', 'staff'])
    context = {'products': products, 'employees': employees}
    return render(request, 'jewelry_demo_app/admin_dashboard.html', context)

@login_required
@user_passes_test(is_designer_or_admin)
def manage_products(request):
    if request.method == 'POST':
        if 'add_product' in request.POST:
            name = request.POST.get('name')
            price = request.POST.get('price')
            if name and price:
                try:
                    price = float(price)
                    if price < 0:
                        raise ValidationError("價格不能為負數")
                    Product.objects.create(name=name, price=price, image_url='')
                    return redirect('backend:manage_products')
                except ValueError:
                    return render(request, 'jewelry_demo_app/manage_products.html', {'products': Product.objects.all(), 'error': '價格格式錯誤'})
        elif 'delete_product' in request.POST:
            product_id = request.POST.get('product_id')
            Product.objects.filter(id=product_id).delete()
            return redirect('backend:manage_products')

    products = Product.objects.all()
    return render(request, 'jewelry_demo_app/manage_products.html', {'products': products})

def login_view(request):
    if request.user.is_authenticated:
        return redirect('backend:home')
    return LoginView.as_view(template_name='jewelry_demo_app/login.html')(request)

def logout_view(request):
    logout(request)
    return redirect('backend:home')