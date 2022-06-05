// import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:go_router/go_router.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:labpract/domain/auth/entity/auth_model.dart';
// import 'package:labpract/infra/core/data_provider.dart';
// import 'package:labpract/infra/core/miesitu_urls.dart';
// import 'package:today/domain/auth/entity/auth_model.dart';
// import 'package:today/infra/core/data_provider.dart';
// import 'package:today/infra/core/miesitu_urls.dart';

// class AuthDataProvider extends DataProvider {
//   loginUser(String email, String password) async {
//      String email;
//     String password;
//     // var user;

//     final response = await http.post(
//       loginUrl,
//       body: jsonEncode(<String, String>{
//         'email': email.toString(),
//         'password': password,
//       }),
//     );

//     if (response.statusCode == 200) {
//       // user = User.fromJson(jsonDecode(response.body));
//       return true;
//       // await saveUserOnLocal(user);
//       // print(response.body[])
//     } else {
//       throw Exception("Invalid login");
//     }
//     return false;
//   }

Future<bool> registerUser(Register register) async {
  String username = register.username;
  String email = register.email;
  String password2 = register.password2;
  String password = register.password;
  String firstName = register.first_name;
  String lastName = register.last_name;

<<<<<<< HEAD
  // String route = 'https://mitane-backend.herokuapp.com/auth';
  // String route = 'http://127.0.0.1:8000/api/register';
  // switch (role) {
  //   case 'user':
  //     route += '/api/register';
  //     break;
  //   // case 'admin':
  //   //   route += '/admin/register';
  //   //   break;
  //   // default:
  //   //   route += '/u/signup';
  //   //   break;
  // }

  // try {
=======
>>>>>>> f1942a148f6737ce258d15325cd8de66c71659fe
  print(username);
  print(email);

  final response =
<<<<<<< HEAD
      await http.post(Uri.parse("http://127.0.0.1:8000/api/register/"),
          // headers: <String, String>{
          //   'Content-Type': 'application/json; charset=UTF-8',
          // },
          // headers: {},
          body:
              //  jsonEncode(<String, String>{
              {
        "username": username,
        "email": email,
        "password": password,
        "password2": password2,
        "first_name": firstName,
        "last_name": lastName,
      });
=======
      await http.post(Uri.parse("http://127.0.0.1:8000/api/register/"), body:
          //  jsonEncode(<String, String>{
          {
    "username": username,
    "email": email,
    "password": password,
    "password2": password2,
    "first_name": firstName,
    "last_name": lastName,
  });
>>>>>>> f1942a148f6737ce258d15325cd8de66c71659fe
  // print('herereeeeeeeeeeeeeeeeeeeeeee');
  print(response.body);
  if (response.statusCode == 201) {
    // print(response.body); //go to login page
    return true;
  } else
    return false;
  // }
  // catch (e) {
  // print("vufiddhfdusdvdfdgiiiiiiiiiiiiiiiiiiiiiiiooooooooooo");
  // rethrow;
  // }

  // try {
  //   final response = await http.post(
  //     registerUrl,
  //     // headers: <String, String>{
  //     //   'Content-Type': 'application/json; charset=UTF-8',
  //     // },
  //     body: jsonEncode(<String, String>{
  //       'username': username,
  //       'email': email,
  //       'password': password,
  //       'password2': password2,
  //       'first_name': first_name,
  //       'last_name': last_name,
  //     }),
  //   );
  //   print('here');
  //   if (response.statusCode == 200) {
  //     print(response.body); //go to login page
  //     return true;
  //   }

  //   return false;
  // } catch (e) {
  //   rethrow;
  // }
}

  // static Future<bool> saveUserOnLocal(User user) async {
  //   try {
  //     await storage.write(key: "username", value: user.username);
  //     await storage.write(key: "first_name", value: user.first_name);
  //     await storage.write(key: "last_name", value: user.last_name);
  //     await storage.write(key: "email", value: user.email);
  //     await storage.write(key: "id", value: user.id);
  //     await storage.write(key: "role", value: user.roles[0].toString());
  //     await storage.write(key: "password", value: user.password);
  //     await storage.write(key: "token", value: user.token);
  //     return true;
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  // Future<Map<String, dynamic>> getUserOnLocal() async {
  //   if (await storage.containsKey(key: 'token')) {
  //     String? token = await storage.read(key: 'token');
  //     String? username = await storage.read(key: 'username');
  //     String? first_name = await storage.read(key: 'first_name');
  //     String? last_name = await storage.read(key: 'last_name');
  //     String? id = await storage.read(key: 'id');
  //     String? phone = await storage.read(key: 'phone');
  //     String? role = await storage.read(key: 'role');
  //     String? password = await storage.read(key: 'password');

  //     return {
  //       '_id': id,
  //       'name': username,
  //       'first_name': first_name,
  //       'last_name': last_name,
  //       'token': token,
  //       'phone': phone,
  //       'roles': [role],
  //       'password': password
  //     };
  //   } else {
  //     return {};
  //   }
  // }

  // static String? getStringToken() {
  //   AuthDataProvider.getToken().then((value) => value);
  // }

// }

// // import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:today/domain/auth/entity/auth_model.dart';
// import 'package:today/infra/core/data_provider.dart';
// import 'package:today/infra/core/miesitu_urls.dart';

// class AuthDataProvider extends DataProvider {
//   // final http.Client httpClient;
//   // final Dio dio;
//   final authUrl = BaseUrl.authBaseUrl;
//   static final storage = FlutterSecureStorage();
//   AuthDataProvider({required this.dio});

//   Future<User> loginUser(Login login) async {
//     final String phone = login.phone;
//     final String password = login.password;
//     var user;
//     var code = '+251';

//     if (phone == '911111111' || phone == '922222222' || phone == '900000000') {
//       code = '251';
//     }
//     final response = await dio.post("$authUrl/login",
//         data: {'phone_no': '$code$phone', 'password': password});
//     if (response.statusCode == 200 || response.statusCode == 204) {
//       user = User.fromJson(response.data);
//       await saveUserOnLocal(user);
//     } else {
//       throw Exception("Invalid login");
//     }
//     return user;
//   }

//   Future<bool> registerUser(Register register) async {
//     final String name = register.name;
//     final String phone = register.phone;
//     final String confirm = register.confirm;
//     final String role = register.role;
//     final String password = register.password;

//     String route = 'https://mitane-backend.herokuapp.com/auth';
//     switch (role) {
//       case 'farmer':
//         route += '/f/signup';
//         break;
//       case 'accessory trader':
//         route += '/at/signup';
//         break;
//       case 'product trader':
//         route += '/pt/signup';
//         break;
//       case 'tool trader':
//         route += '/tt/signup';
//         break;
//       default:
//         route += '/u/signup';
//         break;
//     }

//     try {
//       final response = await dio.post("$route", data: {
//         'name': name,
//         'phone_no': phone,
//         'password': password,
//         'repeat_password': confirm
//       });
//       print('here');
//       if (response.statusCode == 200) {
//         print(response.data);
//         return true;
//       }

//       return false;
//     } catch (e) {
//       rethrow;
//     }
//   }

//   // static Future<bool> saveUserOnLocal(User user) async {
//   //   try {
//   //     await storage.write(key: "name", value: user.name);
//   //     await storage.write(key: "phone", value: user.phone);
//   //     await storage.write(key: "id", value: user.id);
//   //     await storage.write(key: "role", value: user.roles[0].toString());
//   //     await storage.write(key: "password", value: user.password);
//   //     await storage.write(key: "token", value: user.token);
//   //     return true;
//   //   } catch (e) {
//   //     throw e;
//   //   }
//   // }

//   // Future<Map<String, dynamic>> getUserOnLocal() async {
//   //   if (await storage.containsKey(key: 'token')) {
//   //     String? token = await storage.read(key: 'token');
//   //     String? name = await storage.read(key: 'name');
//   //     String? id = await storage.read(key: 'id');
//   //     String? phone = await storage.read(key: 'phone');
//   //     String? role = await storage.read(key: 'role');
//   //     String? password = await storage.read(key: 'password');

//   //     return {
//   //       '_id': id,
//   //       'name': name,
//   //       'token': token,
//   //       'phone': phone,
//   //       'roles': [role],
//   //       'password': password
//   //     };
//   //   } else {
//   //     return {};
//   //   }
//   // }

//   // static String? getStringToken() {
//   //   AuthDataProvider.getToken().then((value) => value);
//   // }

// }
