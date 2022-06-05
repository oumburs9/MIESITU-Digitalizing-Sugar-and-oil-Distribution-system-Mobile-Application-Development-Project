import 'dart:convert';

List<Customers> customersFromJson(String str) =>
    List<Customers>.from(json.decode(str).map((x) => Customers.fromJson(x)));

String customersToJson(List<Customers> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Customers {
  Customers({
    this.userName,
    this.firstName,
    required this.email,
    this.lastName,
    required this.id,
  });

  String? userName;
  String? firstName;
  String email;
  String? lastName;
  String id;

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
        userName: json["user_name"],
        firstName: json["first_name"],
        email: json["email"],
        lastName: json["last_name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_name": userName,
        "first_name": firstName,
        "email": email,
        "last_name": lastName,
        "id": id,
      };
}
