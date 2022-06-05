from .models import Customer, Announcement, Feedback, Products
from django.contrib import admin

# Register your models here.
admin.site.register(Customer)
admin.site.register(Products)
admin.site.register(Announcement)
admin.site.register(Feedback)