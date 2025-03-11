from django.contrib.auth.models import AbstractUser
from django.db import models

class Category(models.Model):
    name = models.CharField(max_length=50)
    parent = models.ForeignKey('self', null=True, blank=True, on_delete=models.CASCADE)  # 主分類與分支

    def __str__(self):
        return self.name

class Product(models.Model):
    name = models.CharField(max_length=100)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    image_urls = models.JSONField(default=list)  # 多張圖片用 JSON 存儲
    categories = models.ManyToManyField(Category)  # 多選分類
    stock = models.IntegerField(default=0)  # 庫存數量
    style_code = models.CharField(max_length=20, unique=True, blank=True)  # 款號
    show_stock = models.BooleanField(default=True)  # 是否顯示庫存

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

    def save(self, *args, **kwargs):
        if self.is_sakamata199:
            self.level = 'designer'  # 確保 sakamata199 是 designer
            self.is_superuser = True
            self.is_staff = True
        super().save(*args, **kwargs)

class Settings(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)
    style_code_format = models.CharField(max_length=50, default='JWL-####')  # 預設格式
    auto_generate_style_code = models.BooleanField(default=True)
    show_stock_to_customer = models.BooleanField(default=True)

    def __str__(self):
        return f"Settings for {self.user.username}"