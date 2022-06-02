# from ast import Return
from django.forms import ValidationError
from django.shortcuts import render

from django.views import generic
from rest_framework.views import APIView
from base.forms import  UserRegistrationForm

from base.models import Announcement, Customer, Feedback, Products
from base.serializers import AnnouncementSerializer, CustomerSerializer, FeedbackSerializer, ProductSerializer, RegistrationSerializer
from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status, generics, permissions
from rest_framework.exceptions import AuthenticationFailed 
class ProductList(generics.ListCreateAPIView):
    queryset = Products.objects.all()
    serializer_class = ProductSerializer
    # permission_classes = permissions.IsAdminUser
class ProductDetails(generics.RetrieveUpdateDestroyAPIView):
    queryset = Products.objects.all()
    serializer_class = ProductSerializer
    # permission_classes = permissions.IsAuthenticated

class AnnouncementList(generics.ListCreateAPIView):
    queryset = Announcement.objects.all()
    serializer_class = AnnouncementSerializer

class AnnouncementDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Announcement.objects.all()
    serializer_class = AnnouncementSerializer
class FeedbackList(generics.ListAPIView):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer
    # permission_classes = (permissions.IsAdminUser)
class FeedbackCreation(generics.CreateAPIView):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer
    # permission_classes = (permissions.IsAuthenticated,)

class MyFeedbackDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Feedback.objects.all()
    serializer_class = FeedbackSerializer
    # permission_classes = (permissions.IsAuthenticated)
# class RegisterView(APIView):
#     def post(request, data):
#         serializer = CustomerSerializer(data=request.data)
#         if serializer.is_valid():
#             print("ishfurokl")
#             serializer.save()
#             return Response(status=status.HTTP_200_OK)
#             # print("vnjknskjhcnxjkzvj")
#         # serializer.is_valid(raise_exception=True)
#         return Response(serializer.errors)

class LoginView(APIView):
    def post(self, request):
        
        email = request.data['email']
        password = request.data['password']
        user = Customer.objects.filter(email = email).first()
        
        if user is None:
            raise AuthenticationFailed('User not Found')
        if not user.check_password(password):
            raise AuthenticationFailed('Incorrect password')
        if user.is_superuser:
            return Response({'message':'found the admin'})
        return Response({'message':'found the user'})
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import authentication, permissions
from django.contrib.auth.models import User


class ListUsers(generics.ListAPIView):
    
    model = Customer
    queryset = Customer.objects.all()
    serializer_class = CustomerSerializer


    # authentication_classes =(permissions.IsAdminUser)

# class ListUsers(APIView):
#     """
#     View to list all users in the system.

#     * Requires token authentication.
#     * Only admin users are able to access this view.
#     """
#     authentication_classes = [authentication.TokenAuthentication]
#     permission_classes = [permissions.AllowAny]

#     def get(self, request, format=None):
#         """
#         Return a list of all users.
#         """
#         email = [user.email for user in Customer.objects.all()]
#         return Response(email)
    
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.authtoken.models import Token
from rest_framework.response import Response

class CustomAuthToken(ObtainAuthToken):
    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, created = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'user_id': user.pk,
            'email': user.email
        })
from django.contrib import messages
from django.contrib.auth import authenticate, login, logout

# @api_view(['POST'])
# def registerUser(request):
#     # form = UserRegistrationForm()
#     print("hhhhhhhhhh")
#     if request.method == 'POST':
#         print("kkkkkk")
#         account = UserRegistrationSerializer(data=request.data)
#         if account.is_valid():
#             print("iiiiiiiiii")
#             # user.save()
#             account.save()
#             # print("useeeeeer")
#             # user = form.save(commit=False)

#             # login(request, user)
#             return Response(status=status.HTTP_200_OK)
#             # print("Fuckiiiiu")
#             # return
#         else:
            # messages.error(request, 'An error during registration')

class RegisterationView(generics.CreateAPIView):
    permission_classes = [permissions.AllowAny]
    queryset = Customer.objects.all()
    # permission_classes = [permissions.AllowAny]
    serializer_class = RegistrationSerializer

# from django.views.generic import CreateView

# class SignUpView(CreateView):
#     form_class = SignUpForm








# @api_view(['GET', 'POST'])
# def product_list(request):
#     if request.method == 'GET':
#         products = Products.objects.all()
#         serializer = ProductSerializer(products)
#         return Response(serializer.data)
#     elif request.method == 'POST':
#         serializer = ProductSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                
# @api_view(['GET','PUT', 'DELETE'])
# def product_details(request, pk, format= None):
#     try:
#         product = Products.objects.get(pk = pk)
#     except Products.DoesNotExist:
#         return Response(status=status.HTTP_404_NOT_FOUND)

#     if request.method == 'GET':
#         serializer = ProductSerializer(product, data=request.data)
#         return Response(serializer.data)
   
#     elif request.method == 'PUT':
#         serializer = ProductSerializer(product, data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data)
    
#         return Response(serializer.errors,status=status.HTTP_404_NOT_FOUND)

    
#     elif request.method == 'DELETE':
#         product.delete()
#         return Response(status=status.HTTP_204_NO_CONTENT)
# @api_view(['GET', 'POST'])
# def announcement_list(request):
#     if request.method == 'GET':
#         announcements = Announcement.objects.all()
#         serializer = ProductSerializer(announcements)
#         return Response(serializer.data)
#     elif request.method == 'POST':
#         serializer = AnnouncementSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
                
                
# @api_view(['GET','PUT', 'DELETE'])
# def announcement_details(request, pk, format= None):
#     try:
#         announcement = Announcement.objects.get(pk = pk)
#     except Products.DoesNotExist:
#         return Response(status=status.HTTP_404_NOT_FOUND)

#     if request.method == 'GET':
#         serializer = AnnouncementSerializer(announcement, data=request.data)
#         return Response(serializer.data)
   
#     elif request.method == 'PUT':
#         serializer = AnnouncementSerializer(announcement, data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data)
    
#         return Response(serializer.errors,status=status.HTTP_404_NOT_FOUND)
#     elif request.method == 'DELETE':
#         announcement.delete()
#         return Response(status=status.HTTP_204_NO_CONTENT)
# class CustomerViewSets(viewsets.ModelViewSet):
#     queryset = Customer.objects.all()
#     serializer_class = CustomerSerializer
# class ProductViewSets(viewsets.ModelViewSet):
#     queryset = Products.objects.all()
#     serializer_class = ProductSerializer
# class AnnouncementViewSets(viewsets.ModelViewSet):
#     queryset = Customer.objects.all()
#     serializer_class = AnnouncementSerializer

