from dataclasses import fields
from django.forms import ModelForm
from django.contrib.auth.forms import UserCreationForm
from .models import Customer


class UserRegistrationForm(UserCreationForm):
    class Meta:
        model = Customer
        fields = ['username', 'first_name', 'last_name', 'email', 'password1', 'password2']
# class UserForm(ModelForm):
#     class Meta:
#         model = Customer
#         fields = '__all__'
#         fields = ['img', 'name', 'username', 'email', 'bio']