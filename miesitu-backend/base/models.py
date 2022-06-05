# from enum import unique
from django import forms
from django.db import models
from django.contrib.auth.models import AbstractUser


class Customer(AbstractUser):
    email = models.CharField(max_length=200, unique=True)
    password = models.CharField( max_length=200, null=True, )
    cust_img = models.ImageField(null=True, blank = True)
    # name = models.CharField(max_length=200, null=True)
    # bio = models.TextField(null=True)
    # avatar = models.ImageField(null=True, default="avatar.svg")
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = [email]
class Products(models.Model):
    product_name = models.CharField(max_length=300, null=True)
    product_price = models.CharField(max_length=300)
    product_start_date = models.DateTimeField(null=True)
    product_end_date = models.DateTimeField(null=True)
    product_img = models.ImageField(null=True)
    # img = models.ImageField()
    def __str__(self):
        return self.product_name
    
class Announcement(models.Model):
    announcement_subject = models.CharField(max_length=300)
    announcement_body = models.CharField(max_length=2000)
    announced_at = models.DateField(auto_now_add=True)
    update_announcement = models.DateField(auto_now=True)
    
    def __str__(self) :
        return self.announcement_subject
    
class Feedback(models.Model):
    feedback_subject = models.CharField(max_length=300)
    feedback_body = models.CharField(max_length=2000)
    def __str__(self) :
        return self.feedback_subject
    
from django.conf import settings
from django.db.models.signals import post_save
from django.dispatch import receiver
from rest_framework.authtoken.models import Token
@receiver(post_save, sender=settings.AUTH_USER_MODEL)
def create_auth_token(sender, instance=None, created=False, **kwargs):
    if created:
        Token.objects.create(user=instance)