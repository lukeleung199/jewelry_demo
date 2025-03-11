from django.contrib import admin
from .models import Category, Product, Customer, Order, CustomUser, Settings, Featured

admin.site.register(Category)
admin.site.register(Product)
admin.site.register(Customer)
admin.site.register(Order)
admin.site.register(CustomUser)
admin.site.register(Settings)
admin.site.register(Featured)