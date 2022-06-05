import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miesitu/application/auth/events/auth_events.dart';
import 'package:miesitu/application/auth/states/auth_state.dart';

import 'package:miesitu/infrastructure/auth/repository/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(
    this.authRepository,
  ) : super(InitState()) {
    on<RegisterEvent>((event, emit) async {
      {
        emit(Registering());

        bool res = await authRepository.signUp(event.register);

        if (res) {
          emit(RegisterSuccess());
        } else if (res == false) {
          emit(RegisterError("error bea"));
        }
      }
    });

    on<LoginEvent>((event, emit) async {
      {
        emit(LoggingIn());
        try {
          print('Logfgfgfdgfdging');
          print(event.login);
          print(event.login.email);
          print(event.login.password);
          Map res = await authRepository.signIn(
              event.login.email, event.login.password);
          if (res["type"] == "admin") {
            print("aaaaaaaaadddddddmmmiiiiiiiiiin");
            emit(AdminLoginSuccess());
            return;
          }
          emit(LoginSuccess());
        } catch (e) {
          print(e);
          print("oooooooooooooooooooo");
          emit(LogginError("Logiin failed:${e.toString()} }"));
        }
      }
    });
  }
}
