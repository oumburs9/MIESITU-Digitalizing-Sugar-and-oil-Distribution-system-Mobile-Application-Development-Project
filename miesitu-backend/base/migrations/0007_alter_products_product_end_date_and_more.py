# Generated by Django 4.0.4 on 2022-05-29 08:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0006_alter_customer_email'),
    ]

    operations = [
        migrations.AlterField(
            model_name='products',
            name='product_end_date',
            field=models.DateTimeField(null=True),
        ),
        migrations.AlterField(
            model_name='products',
            name='product_start_date',
            field=models.DateTimeField(null=True),
        ),
    ]
