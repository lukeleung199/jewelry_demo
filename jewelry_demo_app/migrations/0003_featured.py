# Generated by Django 5.1.7 on 2025-03-11 04:08

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('jewelry_demo_app', '0002_remove_product_category_remove_product_image_url_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='Featured',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('title', models.CharField(blank=True, max_length=100, null=True)),
                ('main_image', models.URLField(blank=True, null=True)),
                ('featured_products', models.ManyToManyField(blank=True, to='jewelry_demo_app.product')),
            ],
        ),
    ]
