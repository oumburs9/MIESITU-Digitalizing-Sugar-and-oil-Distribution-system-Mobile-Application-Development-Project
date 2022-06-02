
from django.contrib import admin
from django.urls import path
from base import views

# from base.views import product_list
from rest_framework_simplejwt.views import (
    TokenObtainPairView,
    TokenRefreshView,
)

urlpatterns = [
    # path('customers/',CustomerView.as_view()),
    
    # path('products/',views.product_list),
    # path('products/<int:pk>/',views.product_details),
    
    path('products/',views.ProductList.as_view()),
    path('products/<int:pk>/',views.ProductDetails.as_view()),

    path('announcement/',views.AnnouncementList.as_view()),
    path('announcement/<int:pk>/',views.AnnouncementDetail.as_view()),
        
    path('feedbacks/',views.FeedbackList.as_view()),
    path('feedback/',views.FeedbackCreation.as_view()),
    path('feedback/<int:pk>/',views.MyFeedbackDetail.as_view()),
    
    #  path('signup/', views.SignUpView.as_view(), name='signup'),
    path('users/',views.ListUsers.as_view()),
    # path('token/auth/', views.CustomAuthToken.as_view())
    path('token/', TokenObtainPairView.as_view(), name='token_obtain_pair'),
    path('tokken/', views.CustomAuthToken.as_view(), name='token_obtain_pair'),
    # path('token/refresh/', TokenRefreshView.as_view(), name='token_refresh'),
    # path('register/', views.RegisterView.as_view()),
    path('register/', views.RegisterationView.as_view()),
    path('login/', views.LoginView.as_view()),
        
    # path('customers/',CustomerView.as_view()),   
    # path('customers/',CustomerView.as_view),
]