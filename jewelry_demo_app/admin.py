from django.contrib import admin
from .models import CustomUser, Product, Category, Customer, Order

admin.site.register(CustomUser)
admin.site.register(Product)
admin.site.register(Category)
admin.site.register(Customer)
admin.site.register(Order)