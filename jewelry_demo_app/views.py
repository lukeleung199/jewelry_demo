from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth import logout
from django.contrib.auth.views import LoginView
from .models import CustomUser, Product, Category, Settings
from django.contrib.auth import get_user_model, authenticate, login
from django.core.exceptions import ValidationError
from django.core.paginator import Paginator
import random
import string

User = get_user_model()

def is_designer_or_admin(user):
    return user.level in ['designer', 'admin'] or user.is_sakamata199

def home(request):
    return render(request, 'jewelry_demo_app/index.html')

def product_list(request):
    # 獲取所有產品
    products = Product.objects.all()
    # 分頁，每頁 12 件貨品
    paginator = Paginator(products, 12)  # 每頁 12 件
    page_number = request.GET.get('page', 1)  # 從 URL 獲取頁碼，預設為 1
    page_obj = paginator.get_page(page_number)
    
    context = {
        'products': page_obj,
        'page_obj': page_obj,
    }
    return render(request, 'jewelry_demo_app/product_list.html', context)

# 以下為其他視圖（保持不變）
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
            stock = request.POST.get('stock', 0)
            style_code = request.POST.get('style_code')
            category_ids = request.POST.getlist('categories')
            image_urls = request.POST.getlist('image_urls')

            if name and price:
                try:
                    price = float(price)
                    if price < 0:
                        raise ValidationError("價格不能為負數")
                    product = Product(
                        name=name,
                        price=price,
                        stock=int(stock),
                        style_code=style_code or generate_style_code(request.user),
                        image_urls=image_urls
                    )
                    product.save()
                    if category_ids:
                        product.categories.set(category_ids)
                    return redirect('backend:manage_products')
                except ValueError:
                    return render(request, 'jewelry_demo_app/manage_products.html', {'products': Product.objects.all(), 'categories': Category.objects.all(), 'error': '價格或庫存格式錯誤'})
        elif 'delete_product' in request.POST:
            product_id = request.POST.get('product_id')
            Product.objects.filter(id=product_id).delete()
            return redirect('backend:manage_products')

    products = Product.objects.all()
    categories = Category.objects.all()
    return render(request, 'jewelry_demo_app/manage_products.html', {'products': products, 'categories': categories})

@login_required
@user_passes_test(is_designer_or_admin)
def manage_categories(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        parent_id = request.POST.get('parent')
        if name:
            parent = Category.objects.get(id=parent_id) if parent_id else None
            Category.objects.create(name=name, parent=parent)
            return redirect('backend:manage_categories')

    categories = Category.objects.all()
    return render(request, 'jewelry_demo_app/manage_categories.html', {'categories': categories})

def login_view(request):
    if request.user.is_authenticated:
        return redirect('backend:home')
    
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('backend:home')
        else:
            # 登入失敗時顯示錯誤訊息
            return render(request, 'jewelry_demo_app/login.html', {
                'error': '用戶名或密碼錯誤'
            })
    
    return render(request, 'jewelry_demo_app/login.html')

def logout_view(request):
    logout(request)
    return redirect('backend:home')

def generate_style_code(user=None):
    if user and user.is_sakamata199:
        settings, _ = Settings.objects.get_or_create(user=user)
        if not settings.auto_generate_style_code:
            return None
        format_str = settings.style_code_format
        result = ''
        for char in format_str:
            if char == '*':
                result += random.choice(string.digits)
            elif char == '#':
                result += random.choice(string.ascii_uppercase)
            elif char == '0':
                result += '0'
            else:
                result += char
        return result
    return f"JWL-{''.join(random.choices(string.ascii_uppercase + string.digits, k=4))}"