import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:labpract/application/auth/bloc/auth_bloc.dart';
import 'package:labpract/application/auth/events/auth_events.dart';
import 'package:labpract/application/auth/states/auth_state.dart';
import 'package:labpract/domain/auth/entity/auth_model.dart';
import 'package:labpract/infrastructure/auth/repository/auth_repository.dart';

import 'package:mocktail/mocktail.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  MockAuthRepository authRepository = MockAuthRepository();

  final login = Login(
    email: 'abc@gmail.com',
    password: '123456789',
  );
  Future<List<Login>> signInm() async {
    return [
      Login(
        email: 'abc@gmail.com',
        password: '123456789',
      )
    ];
  }

  Future<Login> signIn1() async {
    return Login(
      email: 'abc@gmail.com',
      password: '123456789',
    );
  }

  setUp(() {
    authRepository = MockAuthRepository();
  });

  blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading,AuthAdminOperationSuccess] when successful',
      build: () {
        when(() => authRepository.signIn(login.email, login.password))
            .thenAnswer((invocation) => signIn1());

        return AuthBloc(authRepository);
      },
      act: (bloc) => bloc);

  () {
    return [isA<AdminLoginSuccess>()];
  };

//
}
