import 'package:labpract/domain/auth/validation/invalid_validation.dart';

class Email {
  final String email;

  List<String> get props => [email];

  factory Email(String email) {
    return Email._(email: validateEmail(email));
  }

  Email._({required this.email});

  static validateEmail(String email) {
    // const phoneRegex = r"""^[0-9]{10}$ """;
    const emailRegex =
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
    if (!(RegExp(emailRegex).hasMatch(email))) {
      throw InvalidEmail(failedValue: "Email invalid");
    }
  }

  @override
  String toString() => 'email: {$email}';
}

class InvalidEmail extends InvalidCredential {
  final String failedValue;

  List<String> get props => [failedValue];
  InvalidEmail({required this.failedValue}) : super(failedValue: failedValue);
}
