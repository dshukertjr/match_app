import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  AuthBloc authBloc;
  group('AuthBloc', () {
    group('user not signed in', () {
      setUp(() {
        final authRepository = MockAuthRepository();

        when(authRepository.getUid).thenAnswer((_) async => null);
        authBloc = AuthBloc(authRepository: authRepository);
      });

      blocTest(
        'emits NoUser when user is not signed in',
        build: () async => authBloc,
        act: (bloc) async => bloc.add(AuthStarted()),
        expect: [AuthNoUser()],
      );
    });

    group('user signed in', () {
      setUp(() {
        final authRepository = MockAuthRepository();

        when(authRepository.getUid).thenAnswer((_) async => 'aaa');
        authBloc = AuthBloc(authRepository: authRepository);
      });

      blocTest(
        'emits NoUser when user is not signed in',
        build: () async => authBloc,
        act: (bloc) async => bloc.add(AuthStarted()),
        expect: [AuthNoProfile()],
      );
    });
  });
  authBloc?.close();
}
