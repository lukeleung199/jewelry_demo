from django.contrib.auth.models import AbstractUser
from django.db import models

class Category(models.Model):
    name = models.CharField(max_length=50)
    parent = models.ForeignKey('self', null=True, blank=True, on_delete=models.CASCADE)
    note = models.TextField(blank=True, null=True)


    def __str__(self):
        return self.name

class Product(models.Model):
    name = models.CharField(max_length=255)
    price = models.FloatField()
    stock = models.IntegerField(default=0)
    style_code = models.CharField(max_length=50, unique=True)
    image_urls = models.JSONField(default=list)
    is_featured = models.BooleanField(default=False)
    categories = models.ManyToManyField('Category', related_name='products')
    note = models.TextField(blank=True, null=True, default='')  # 添加 note 字段
    product_data = models.TextField(blank=True, null=True, default='')  # 添加 product_data 字段

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
            self.level = 'designer'
            self.is_superuser = True
            self.is_staff = True
        super().save(*args, **kwargs)

class Settings(models.Model):
    user = models.OneToOneField(CustomUser, on_delete=models.CASCADE)
    style_code_format = models.CharField(max_length=50, default='JWL-####')
    auto_generate_style_code = models.BooleanField(default=True)
    show_stock_to_customer = models.BooleanField(default=True)

    def __str__(self):
        return f"Settings for {self.user.username}"

class Featured(models.Model):
    title = models.CharField(max_length=100, blank=True, null=True)
    main_image = models.URLField(max_length=200, blank=True, null=True)
    featured_products = models.ManyToManyField(Product, blank=True)

    def __str__(self):
        return self.title or "精選展示"