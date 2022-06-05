import 'package:miesitu/domain/auth/entity/auth_model.dart';

abstract class AuthState {}

// login user state
class InitState extends AuthState {}

class LoggedInState extends AuthState {
  final Map<String, dynamic> userData;
  LoggedInState({required this.userData});
}

class LoggedOutState extends AuthState {}

class LoggingIn extends AuthState {}

class LoginSuccess extends AuthState {
  // final User user;

  // LoginSuccess({required this.user});
}

class AdminLoginSuccess extends AuthState {
  // final User user;
  // AdminLoginSuccess({required this.user});
}

class LogginError extends AuthState {
  final String errorMsg;

  LogginError(this.errorMsg);
}

// logut user state
class Logout extends AuthState {}

// register user state
// class OTPMessageSend extends AuthState {}

// class VerificationSuccessful extends AuthState {}

class Registering extends AuthState {}

class RegisterSuccess extends AuthState {}

class RegisterError extends AuthState {
  final errorMessage;
  RegisterError(this.errorMessage);
}

// forgot password
