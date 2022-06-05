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
  final String? id;

  final String username;

  final String accesstoken;

  final String email;

  // final List<dynamic> roles;

  // final String avatar;

  final String password;

  final String? first_name;

  final String? last_name;
  final String refreshtoken;

  User({
    this.id,
    required this.username,
    required this.accesstoken,
    required this.email,
    required this.password,
    this.first_name,
    this.last_name,
    required this.refreshtoken,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      accesstoken: json['accesstoken'],
      email: json['email'],
      password: json['password'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      refreshtoken: json['refreshtoken'],
    );
  }
}
