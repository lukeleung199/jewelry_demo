from django.contrib.auth.models import AbstractUser
from django.db import models

class Category(models.Model):
    name = models.CharField(max_length=50)

    def __str__(self):
        return self.name

class Product(models.Model):
    name = models.CharField(max_length=100)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    image_url = models.URLField(blank=True)
    category = models.ForeignKey(Category, on_delete=models.SET_NULL, null=True, blank=True)

    def __str__(self):
        return self.name

class Customer(models.Model):
    email = models.EmailField(unique=True)
    phone = models.CharField(max_length=15, null=True, blank=True)
    uid = models.CharField(max_length=8, unique=True, default="TEMP000")
    password = models.CharField(max_length=128)
    shipping_address = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.email

class Order(models.Model):
    customer = models.ForeignKey(Customer, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField()
    total_price = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(max_length=20, default="pending")
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Order {self.id} by {self.customer.email}"

class CustomUser(AbstractUser):
    LEVEL_CHOICES = (
        ('designer', '設計者'),
        ('admin', '管理員'),
        ('staff', '員工'),
    )
    level = models.CharField(max_length=10, choices=LEVEL_CHOICES, default='staff')
    phone = models.CharField(max_length=15, null=True, blank=True)
    address = models.TextField(null=True, blank=True)

    def __str__(self):
        return self.username

    @property
    def is_sakamata199(self):
        return self.username == 'sakamata199'