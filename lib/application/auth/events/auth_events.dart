import 'package:miesitu/domain/auth/entity/auth_model.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final Login login;

  Login get props => login;

  LoginEvent({required this.login});
}

class LogoutEvent extends AuthEvent {
  final logout;
  LogoutEvent({required this.logout});
}

// class NextButtonPressed extends AuthEvent {
//   final phone;
//   final dialCode;
//   NextButtonPressed(this.phone, this.dialCode);
// }

// class VerificationButtonPressed extends AuthEvent {
//   final verificationCode;
//   VerificationButtonPressed(this.verificationCode);
// }

class RegisterEvent extends AuthEvent {
  final Register register;
  Register get props => register;

  RegisterEvent({required this.register});
}
