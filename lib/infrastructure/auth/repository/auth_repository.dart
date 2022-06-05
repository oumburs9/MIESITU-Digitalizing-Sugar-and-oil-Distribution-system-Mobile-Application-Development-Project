// import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:labpract/application/auth/events/auth_events.dart';
import 'package:labpract/domain/auth/entity/auth_model.dart';
import 'package:labpract/domain/auth/validation/invalid_validation.dart';
import 'package:labpract/infrastructure/auth/data_provider/auth_provider.dart';
import 'package:labpract/domain/auth/entity/auth_model.dart';
import 'package:labpract/domain/auth/validation/invalid_validation.dart';
import 'package:labpract/infrastructure/auth/data_provider/auth_provider.dart';

Map<String, dynamic>? loginData;

class AuthRepository {
  // final AuthDataProvider authDataProvider;

  // AuthRepository({required this.authDataProvider});

  signIn(String email, String password) async {
    try {
      print("emaaaaaaaaaail");
      print(email);
      print(email.toString());

      var response =
          await http.post(Uri.parse("http://127.0.0.1:7000/api/login/"),
              // body: jsonEncode(<String, String>{
              body: {
            "email": email,
            "password": password,
          });
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(response.body);
        loginData = json.decode(response.body);
        print(json.decode(response.body));
        print("----------------------");
        // print(loginData);
        return json.decode(response.body);
      }
      // return false;
      // return await authDataProvider.loginUser(String email, String password);
    } catch (e) {
      // print("caughttttttnjhhhhhhhhbhjbhhtt");
      // print(e);

      throw InvalidCredential(failedValue: e.toString());
    }
  }

  // late RegisterEvent registerEvent;
  Future<bool> signUp(Register register) async {
    print(("fhuisdfhdsiffffffffffff"));
    print(register.first_name);
    print(register.last_name);
    final response = await http.post(
      Uri.parse("http://127.0.0.1:7000/api/register/"),
      body: {
        "username": register.username,
        "first_name": register.first_name,
        "last_name": register.last_name,
        "email": register.email,
        "password": register.password,
        "password2": register.password2,
      },
    );
    print("signUp response :: " + response.body.toString());
    print(register.email);
    if (response.statusCode == 201) {
      // print(response.body); //go to login page
      return true;
    } else
      return false;
    // final response = await authDataProvider.registerUser(register);
    // return response;
  }

  checkUser() {}
}
