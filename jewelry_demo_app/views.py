import os
from django.conf import settings
from django.core.files.storage import FileSystemStorage
from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required, user_passes_test
from django.contrib.auth import logout, authenticate, login
from django.contrib.auth.views import LoginView
from .models import CustomUser, Product, Category, Settings, Featured
from django.contrib.auth import get_user_model
from django.core.exceptions import ValidationError
from django.core.paginator import Paginator
from django.db.models import Sum, Count, Q
import random
import string
from django.http import JsonResponse

# 定義 sanitize_filename 函數
def sanitize_filename(filename):
    # 移除非法字符
    return ''.join(c for c in filename if c.isalnum() or c in ['.', '-', '_']).rstrip()

User = get_user_model()

def is_designer_or_admin(user):
    return user.level in ['designer', 'admin'] or user.is_sakamata199

def home(request):
    featured = Featured.objects.first()
    context = {'featured': featured}
    return render(request, 'jewelry_demo_app/index.html', context)

def product_list(request):
    products = Product.objects.all()
    paginator = Paginator(products, 12)
    page_number = request.GET.get('page', 1)
    page_obj = paginator.get_page(page_number)
    
    categories = Category.objects.filter(parent__isnull=True)
    category_filter = request.GET.get('category')
    if category_filter:
        products = products.filter(categories__name=category_filter)
        paginator = Paginator(products, 12)
        page_obj = paginator.get_page(page_number)
    
    context = {'products': page_obj, 'page_obj': page_obj, 'categories': categories}
    return render(request, 'jewelry_demo_app/product_list.html', context)

def contact(request):
    return render(request, 'jewelry_demo_app/contact.html')

@login_required
@user_passes_test(is_designer_or_admin)
def dashboard(request):
    products = Product.objects.all()
    employees = User.objects.filter(level__in=['admin', 'staff'])
    context = {'products': products, 'employees': employees}
    return render(request, 'jewelry_demo_app/dashboard.html', context)

@login_required
@user_passes_test(is_designer_or_admin)
def manage_products(request):
    if request.method == 'POST':
        if 'add_product' in request.POST:
            name = request.POST.get('name')
            price = request.POST.get('price')
            stock = request.POST.get('stock', 0)
            style_code = request.POST.get('style_code') or generate_style_code(request.user)
            main_category_id = request.POST.get('main_category')
            sub_category_id = request.POST.get('sub_category')
            note = request.POST.get('note', '')
            product_data = request.POST.get('product_data', '')

            if name and main_category_id:
                try:
                    price = float(price) if price else 0
                    if price < 0:
                        raise ValidationError("價格不能為負數")
                    product = Product(
                        name=name,
                        price=price,
                        stock=int(stock) if stock else 0,
                        style_code=style_code,
                        note=note,
                        product_data=product_data,
                        is_featured=False,
                        image_urls=[]  # 初始化為空列表
                    )
                    product.save()
                    # 保存分類
                    main_category = Category.objects.get(id=main_category_id)
                    product.categories.add(main_category)
                    if sub_category_id:
                        sub_category = Category.objects.get(id=sub_category_id)
                        product.categories.add(sub_category)
                    # 保存圖片
                    if 'image_upload' in request.FILES:
                        fs = FileSystemStorage(location=os.path.join(settings.MEDIA_ROOT, 'product_images'))
                        for image in request.FILES.getlist('image_upload'):
                            # 處理文件名
                            sanitized_filename = sanitize_filename(image.name)
                            filename = fs.save(sanitized_filename, image)
                            file_url = fs.url(filename)
                            product.image_urls.append(file_url)
                        product.save()
                    return redirect('backend:manage_products')
                except ValueError:
                    return render(request, 'jewelry_demo_app/manage_products.html', {
                        'products': Product.objects.all(),
                        'main_categories': Category.objects.filter(parent__isnull=True),
                        'error': '價格或庫存格式錯誤'
                    })
        elif 'delete_product' in request.POST:
            product_id = request.POST.get('product_id')
            Product.objects.filter(id=product_id).delete()
            return redirect('backend:manage_products')
        elif 'save_product' in request.POST:
            product_id = request.POST.get('product_id')
            name = request.POST.get('name')
            price = request.POST.get('price')
            stock = request.POST.get('stock')
            main_category_id = request.POST.get('main_category')
            sub_category_id = request.POST.get('sub_category')
            note = request.POST.get('note')
            product_data = request.POST.get('product_data')

            product = Product.objects.get(id=product_id)
            product.name = name
            product.price = float(price) if price else product.price
            product.stock = int(stock) if stock else product.stock
            product.note = note or product.note
            product.product_data = product_data or product.product_data
            product.categories.clear()
            if main_category_id:
                main_category = Category.objects.get(id=main_category_id)
                product.categories.add(main_category)
                if sub_category_id:
                    sub_category = Category.objects.get(id=sub_category_id)
                    product.categories.add(sub_category)
            if 'image_upload' in request.FILES:
                product.image_urls = []
                fs = FileSystemStorage(location=os.path.join(settings.MEDIA_ROOT, 'product_images'))
                for image in request.FILES.getlist('image_upload'):
                    sanitized_filename = sanitize_filename(image.name)
                    filename = fs.save(sanitized_filename, image)
                    file_url = fs.url(filename)
                    product.image_urls.append(file_url)
                product.save()
            return redirect('backend:manage_products')
        elif 'cancel_product' in request.POST:
            return redirect('backend:manage_products')

    # 篩選邏輯
    products = Product.objects.all()
    main_categories = Category.objects.filter(parent__isnull=True)
    selected_main = request.GET.get('main_category')
    selected_sub = request.GET.get('sub_category')
    search_query = request.GET.get('search', '')
    price_value = request.GET.get('price_value', '')
    price_range_enabled = request.GET.get('price_range_enabled', '')
    price_min = request.GET.get('price_min', '')
    price_max = request.GET.get('price_max', '')
    stock_value = request.GET.get('stock_value', '')
    stock_range_enabled = request.GET.get('stock_range_enabled', '')
    stock_min = request.GET.get('stock_min', '')
    stock_max = request.GET.get('stock_max', '')

    # 多條件篩選
    if selected_main:
        products = products.filter(categories__parent__id=selected_main)
        if selected_sub:
            products = products.filter(categories__id=selected_sub)
    if search_query:
        products = products.filter(Q(style_code__icontains=search_query) | Q(name__icontains=search_query))
    if price_value:
        products = products.filter(price=float(price_value))
    elif price_range_enabled:
        price_min = float(price_min) if price_min else None
        price_max = float(price_max) if price_max else None
        if price_min is not None and price_max is not None:
            products = products.filter(price__range=(min(price_min, price_max), max(price_min, price_max)))
    if stock_value:
        products = products.filter(stock=int(stock_value))
    elif stock_range_enabled:
        stock_min = int(stock_min) if stock_min else None
        stock_max = int(stock_max) if stock_max else None
        if stock_min is not None and stock_max is not None:
            products = products.filter(stock__range=(min(stock_min, stock_max), max(stock_min, stock_max)))

    sub_categories = Category.objects.filter(parent__id=selected_main) if selected_main else []
    context = {
        'products': products,
        'main_categories': main_categories,
        'sub_categories': sub_categories,
        'selected_main': selected_main,
        'selected_sub': selected_sub,
        'search_query': search_query,
        'price_value': price_value,
        'price_range_enabled': price_range_enabled,
        'price_min': price_min,
        'price_max': price_max,
        'stock_value': stock_value,
        'stock_range_enabled': stock_range_enabled,
        'stock_min': stock_min,
        'stock_max': stock_max,
    }
    if 'product_id' in request.GET:
        product = Product.objects.get(id=request.GET.get('product_id'))
        return JsonResponse({
            'product': {
                'id': product.id,
                'style_code': product.style_code,
                'name': product.name,
                'price': product.price,
                'stock': product.stock,
                'product_data': product.product_data,
                'note': product.note,
                'image_urls': product.image_urls,
                'categories': [{'id': cat.id, 'name': cat.name, 'parent': {'id': cat.parent.id if cat.parent else None}} for cat in product.categories.all()],
            },
            'sub_categories': [{'id': cat.id, 'name': cat.name} for cat in sub_categories]
        })
    return render(request, 'jewelry_demo_app/manage_products.html', context)

@login_required
@user_passes_test(is_designer_or_admin)
def manage_categories(request):
    if request.method == 'POST':
        if 'add_main_category' in request.POST:
            name = request.POST.get('name')
            note = request.POST.get('note', '')
            if name:
                Category.objects.create(name=name, parent=None, note=note)
                return redirect('backend:manage_categories')
        elif 'add_sub_category' in request.POST:
            name = request.POST.get('name')
            parent_id = request.POST.get('parent')
            note = request.POST.get('note', '')
            if name and parent_id:
                parent = Category.objects.get(id=parent_id)
                Category.objects.create(name=name, parent=parent, note=note)
                return redirect('backend:manage_categories')
        elif 'delete_category' in request.POST:
            category_id = request.POST.get('category_id')
            Category.objects.filter(id=category_id).delete()
            return redirect('backend:manage_categories')
        elif 'save_category' in request.POST:
            category_id = request.POST.get('category_id')
            name = request.POST.get('name')
            note = request.POST.get('note')
            parent_id = request.POST.get('parent')
            category = Category.objects.get(id=category_id)
            old_name = category.name
            category.name = name
            category.note = note
            if parent_id:
                parent = Category.objects.get(id=parent_id)
                category.parent = parent
            else:
                category.parent = None
            category.save()
            # 更新子分類和產品
            if not parent_id:  # 主分類
                sub_cats = Category.objects.filter(parent=category)
                for sub_cat in sub_cats:
                    sub_cat.products.update(categories__name=category.name)
            else:  # 子分類
                products = Product.objects.filter(categories=category)
                for product in products:
                    product.categories.remove(category)
                    product.categories.add(category)  # 更新名稱
            return redirect('backend:manage_categories')
        elif 'cancel_category' in request.POST:
            return redirect('backend:manage_categories')

    categories = Category.objects.all()
    selected_main = request.GET.get('main_category')
    selected_sub = request.GET.get('sub_category')

    main_categories = Category.objects.filter(parent__isnull=True)
    sub_categories = Category.objects.filter(parent__id=selected_main) if selected_main else []

    category_data = []
    main_category_summary = None

    if selected_main and not selected_sub:
        main_category = main_categories.get(id=selected_main)
        sub_cats = categories.filter(parent__id=selected_main)
        
        main_product_count = Product.objects.filter(categories__in=sub_cats).distinct().count()
        main_stock_sum = Product.objects.filter(categories__in=sub_cats).distinct().aggregate(total=Sum('stock'))['total'] or 0
        main_category_summary = {
            'name': main_category.name,
            'sub_category': '-',
            'product_count': main_product_count,
            'stock_sum': main_stock_sum,
            'note': main_category.note or '無',
            'id': main_category.id,
        }

        for category in sub_cats:
            product_count = category.product_set.count()
            stock_sum = category.product_set.aggregate(total=Sum('stock'))['total'] or 0
            category_data.append({
                'main_category': main_category.name,
                'sub_category': category.name,
                'product_count': product_count,
                'stock_sum': stock_sum,
                'note': category.note or '無',
                'id': category.id,
            })
    elif selected_sub:
        sub_cat = categories.get(id=selected_sub)
        main_cat = sub_cat.parent
        product_count = sub_cat.product_set.count()
        stock_sum = sub_cat.product_set.aggregate(total=Sum('stock'))['total'] or 0
        category_data.append({
            'main_category': main_cat.name,
            'sub_category': sub_cat.name,
            'product_count': product_count,
            'stock_sum': stock_sum,
            'note': sub_cat.note or '無',
            'id': sub_cat.id,
        })
    else:
        for category in main_categories:
            sub_cats = categories.filter(parent=category)
            product_count = Product.objects.filter(categories__in=sub_cats).distinct().count()
            stock_sum = Product.objects.filter(categories__in=sub_cats).distinct().aggregate(total=Sum('stock'))['total'] or 0
            category_data.append({
                'main_category': category.name,
                'sub_category': '-',
                'product_count': product_count,
                'stock_sum': stock_sum,
                'note': category.note or '無',
                'id': category.id,
            })

    context = {
        'categories': category_data,
        'main_categories': main_categories,
        'sub_categories': sub_categories,
        'selected_main': selected_main,
        'selected_sub': selected_sub,
        'main_category_summary': main_category_summary,
    }
    if 'category_id' in request.GET:
        category = Category.objects.get(id=request.GET.get('category_id'))
        return JsonResponse({
            'category': {
                'id': category.id,
                'name': category.name,
                'note': category.note,
                'parent': category.parent.id if category.parent else None,
            }
        })
    return render(request, 'jewelry_demo_app/manage_categories.html', context)

@login_required
@user_passes_test(is_designer_or_admin)
def manage_employees(request):
    employees = User.objects.filter(level__in=['admin', 'staff'])
    context = {'employees': employees}
    return render(request, 'jewelry_demo_app/manage_employees.html', context)

@login_required
@user_passes_test(is_designer_or_admin)
def manage_homepage(request):
    featured = Featured.objects.first()
    if request.method == 'POST':
        if 'main_image' in request.POST:
            title = request.POST.get('title', '')
            main_image = request.POST.get('main_image', '')
            if not featured:
                featured = Featured.objects.create(title=title, main_image=main_image)
            else:
                featured.title = title
                featured.main_image = main_image
                featured.save()
            return redirect('backend:manage_homepage')
        elif 'add_product' in request.POST:
            product_id = request.POST.get('product_id')
            product = Product.objects.get(id=product_id)
            if featured:
                featured.featured_products.add(product)
            else:
                featured = Featured.objects.create()
                featured.featured_products.add(product)
            return redirect('backend:manage_homepage')
        elif 'remove_product' in request.POST:
            product_id = request.POST.get('product_id')
            product = Product.objects.get(id=product_id)
            if featured:
                featured.featured_products.remove(product)
            return redirect('backend:manage_homepage')

    products = Product.objects.all()
    context = {'featured': featured, 'products': products}
    return render(request, 'jewelry_demo_app/manage_homepage.html', context)

def login_view(request):
    if request.user.is_authenticated:
        return redirect('backend:dashboard')
    if request.method == 'POST':
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('backend:dashboard')
        else:
            return render(request, 'jewelry_demo_app/login.html', {'error': '用戶名或密碼錯誤'})
    return render(request, 'jewelry_demo_app/login.html')

def logout_view(request):
    logout(request)
    return redirect('backend:login')

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