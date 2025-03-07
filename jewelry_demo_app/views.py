from django.shortcuts import render

# 假數據
PRODUCTS = [
    {"id": 1, "name": "鑽石戒指", "price": 2339.99, "image_url": "https://via.placeholder.com/220x220?text=鑽石戒指"},
    {"id": 2, "name": "黃金項鍊", "price": 1559.99, "image_url": "https://via.placeholder.com/220x220?text=黃金項鍊"},
    {"id": 3, "name": "銀色耳環", "price": 779.99, "image_url": "https://via.placeholder.com/220x220?text=銀色耳環"},
]

def home(request):
    return render(request, 'jewelry_demo_app/home.html')

def product_list(request):
    return render(request, 'jewelry_demo_app/product_list.html', {'products': PRODUCTS})

def contact(request):
    return render(request, 'jewelry_demo_app/contact.html')

def login_view(request):
    return render(request, 'jewelry_demo_app/login.html')