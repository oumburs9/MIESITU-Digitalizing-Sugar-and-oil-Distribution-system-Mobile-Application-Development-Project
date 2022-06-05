abstract class Authentication {}

class Register extends Authentication {
  final String username;

  final String email;

  final String password;

  final String password2;

  // ignore: non_constant_identifier_names
  final String first_name;

  // ignore: non_constant_identifier_names
  final String last_name;

  Register({
    required this.username,
    required this.email,
    required this.password,
    required this.password2,
    // ignore: non_constant_identifier_names
    required this.first_name,
    // ignore: non_constant_identifier_names
    required this.last_name,
  });

  List<Object> get props =>
      [username, email, first_name, last_name, password, password2];

  // factory Register.fromJson(Map<String, dynamic> json) {
  //   return Register(
  //       username: json['username'],
  //       email: json['email'],
  //       password: json['password'],
  //       password2: json['password2'],
  //       first_name: json['first_name'],
  //       last_name: json['last_name']);
  // }

  @override
  String toString() =>
      '{"username": "$username", "email": "$email", "password2": "$password2","password": "$password", "first_name":"$first_name", "last_name":"$last_name"}';
}

class Login extends Authentication {
  final String email;

  final String password;

  Login({required this.email, required this.password});
}

User? currentUser;

class User extends Authentication {
  final String id;

  final String username;

  // final String token;

  final String email;

  // final List<dynamic> roles;

  // final String avatar;

  final String password;

  final String first_name;

  final String last_name;

  User({
    required this.id,
    required this.username,
    // required this.token,
    required this.email,
    required this.password,
    required this.first_name,
    required this.last_name,
  });
  //  :

  // this.avatar =
  // "https://avatars.dicebear.com/api/personas/your-custom-seed.svg";

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      // token: json['token'],
      email: json['email'],
      password: json['password'],
      first_name: json['first_name'],
      last_name: json['last_name'],
    );
  }
}
