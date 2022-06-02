# from tkinter.ttk import Style
from numpy import product
from .models import Announcement, Customer, Feedback, Products
from rest_framework.serializers import ModelSerializer
from rest_framework import serializers


class CustomerSerializer(ModelSerializer):
    class Meta:
        model = Customer
        fields = ['username', 'email', 'first_name', 'last_name', 'password']
class ProductSerializer(ModelSerializer):
    class Meta:
        model = Products
        fields = '__all__'
class AnnouncementSerializer(ModelSerializer):
    class Meta:
        model = Announcement
        fields = '__all__'
        
class FeedbackSerializer(ModelSerializer):
    class Meta:
        model = Feedback
        fields = '__all__'

# class UserRegistrationSerializer(serializers.ModelSerializer):
#     password2 = serializers.CharField(style = {'input_type':'password'}, write_only = True)
#     class Meta:
#         model = Customer
#         fields = ['username', 'email', 'first_name', 'last_name', 'password', 'password2']
#         extra_kwargs = {
#             'password':{'write_only' :True}
#         }
#     def save(self):
#         account = Customer(
#         email = self.validated_data['email'], 
#         # user_name = self.validated_data['user_name'] ,
#         # first_name = self.validated_data['first_name'] ,
#         # last_name = self.validated_data['last_name'] ,
#         password = self.validated_data['password'] ,
#         )
#         password = self.validated_data['password'] 
#         password2 = self.validated_data['password2']
#         if password != password2:
#             raise serializers.ValidationError({'passord':'password must match'}) 
#         account.set_password(password)
#         account.save()

        # return account



# from django.contrib.auth.models import User
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
class RegistrationSerializer(serializers.ModelSerializer):
    email = serializers.EmailField(
                required=True,
                validators=[UniqueValidator(queryset=Customer.objects.all())]
                )
    password = serializers.CharField(write_only=True, required=True, validators=[validate_password])
    password2 = serializers.CharField(write_only=True, required=True)
    cust_img = serializers.ImageField(required =False)
    class Meta:
        model = Customer
        fields = ('username','first_name', 'last_name', 'email', 'password', 'password2','cust_img')
        # extra_kwargs = {
        #     'first_name': {'required': True},
        #     'last_name': {'required': True}
        # }
    def validate(self, attrs):
        if attrs['password'] != attrs['password2']:
            raise serializers.ValidationError({"password": "Password fields didn't match."})
        return attrs
    def create(self, validated_data):
        user = Customer.objects.create(
        # user = User.objects.create(
            username=validated_data['username'],
            email=validated_data['email'],
            first_name=validated_data['first_name'],
            last_name=validated_data['last_name'],
            # cust_img=validated_data['cust_img'],
        )
        user.set_password(validated_data['password'])
        user.save()
        return user












# String _baseUrl = "http://localhost:8080/api/v1/tutorials/";

# http.Client client = InterceptedClient.build(interceptors: [
#   TokenInterceptor(),
# ]);

# class TutorialService{
#   static Future<List<Tutorial>> getAllTutorials(BuildContext context) async {
#     final response = await client.get(
#       Uri.parse(_baseUrl+"all/c"),
#     );

#     if (response.statusCode == 200){
#       print("Entered");
#       Iterable response_body = jsonDecode(response.body);
#       List<Tutorial> tutorialList = List<Tutorial>.from(
#           response_body.map((tutorialItem) => Tutorial.fromJson(tutorialItem)));
#       print(tutorialList);
#       return tutorialList;
#     } else if (response.statusCode == 403){
# 	    Provider.of<AppStateManager>(context, listen:false).logout();
# 	}
#     return [];
#   }
  
#    static Future<List<Tutorial>> getEnrolledTutorials(BuildContext context) async {
# 	print("trying to fetch enrolled tutorials");
#     final response = await client.get(
#       Uri.parse(_baseUrl+"enrolled"),
#     );
	
# 	print("enrolled tutorials fetched with statusCode ${response.statusCode}");

#     if (response.statusCode == 200){
#       Iterable response_body = jsonDecode(response.body);
#       List<Tutorial> tutorialList = List<Tutorial>.from(
#           response_body.map((tutorialItem) => Tutorial.fromJson(tutorialItem)));
#       print(tutorialList);
#       return tutorialList;
#     } else if (response.statusCode == 403){
# 	    Provider.of<AppStateManager>(context, listen:false).logout();
# 	}
#     return [];
#   }
  
#   static Future<List<Tutorial>> getMyTutorials(BuildContext context) async {
# 	print("trying to fetch my tutorials");
#     final response = await client.get(
#       Uri.parse(_baseUrl+"mytutorials"),
#     );
# 	print("My tutorials fetched with statusCode ${response.statusCode}");
#     if (response.statusCode == 200){
#       print("my tutorials 200 status code");
#       Iterable response_body = jsonDecode(response.body);
#       List<Tutorial> tutorialList = List<Tutorial>.from(
#           response_body.map((tutorialItem) => Tutorial.fromJson(tutorialItem)));
#       print(tutorialList);
#       return tutorialList;
#     } else if (response.statusCode == 403){
# 	    Provider.of<AppStateManager>(context, listen:false).logout();
# 	}
#     return [];
#   }

#   static Future<bool> createTutorial(
#       {required String title,
#         required String content,
#         required String projectTitle,
#         required String problemStatement, required BuildContext context}) async {
#     try {
#       final response = await client.post(
#         Uri.parse(_baseUrl),
#         body: jsonEncode(<String, dynamic>{
#           'title': title,
#           'content': content,
#           'project': {
#             'title': projectTitle,
#             'problemStatement': problemStatement,
#           }
#         }),
#       );

#       if (response.statusCode == 201) {
#         return true;
#       } else if (response.statusCode == 403){
# 	    Provider.of<AppStateManager>(context, listen:false).logout();
# 	  }
#       return false;
#     } catch (e) {
#       print(e);
#       return false;
#     }
#   }

#   static Future<bool> updateTutorial(
#       {required String title,
#         required String content,
#         required String projectTitle,
#         required String problemStatement,
#         required int tutorialId, required  BuildContext context}) async {
#     try {
# 	  print("trying to update Tutorial");
#       final response = await client.post(
#         Uri.parse(_baseUrl + tutorialId.toString()),
#         body: jsonEncode(<String, dynamic?>{
#           'title': title,
#           'content': content,
#           'project': {
#             'title': projectTitle,
#             'problemStatement': problemStatement,
#           }
#         }),
#       );
# 	  print("Tutorial Update terminated with statusCode ${response.statusCode}");
#       if (response.statusCode == 201) {
#         return true;
#       } else if (response.statusCode == 403){
# 	    Provider.of<AppStateManager>(context, listen:false).logout();
# 	  }
#       return false;
#     } catch (e) {
#       print(e);
#       return false;
#     }
#   }

#   static Future<bool> deleteTutorial({required int tutorialId, required BuildContext context}) async {
#     try {
#       final response = await client.delete(
#         Uri.parse(_baseUrl + tutorialId.toString()),
#       );

#       if (response.statusCode == 204) {
#         return true;
#       } else if (response.statusCode == 403){
# 	    Provider.of<AppStateManager>(context, listen:false).logout();
# 	  }
#       return false;
#     } catch (e) {
#       print(e);
#       return false;
#     }
#   }

# }