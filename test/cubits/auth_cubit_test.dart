import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/data_providers/firestore_provider.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:cubit_test/cubit_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirestoreProvider extends Mock implements FirestoreProvider {}

class MockAuthRepository extends Mock implements AuthRepository {
  final FirestoreProvider _firestoreProvider;

  MockAuthRepository({FirestoreProvider firestoreProvider})
      : _firestoreProvider = firestoreProvider;
}

void main() {
  AuthCubit authCubit;
  group('AuthCubit not initially logged in', () {
    setUp(() {
      final firestoreProvider = MockFirestoreProvider();

      final authRepository =
          MockAuthRepository(firestoreProvider: firestoreProvider);

      when(authRepository.getUid).thenAnswer((_) async => null);
      when(authRepository.register(email: '', password: ''))
          .thenAnswer((_) async => 'aaa');
      authCubit = AuthCubit(authRepository: authRepository);
    });

    cubitTest<AuthCubit, AuthState>(
      'When the user is not signed in, AuthNoUser is emitted',
      build: () async => authCubit,
      act: (cubit) async => cubit.initialize(),
      expect: [AuthNoUser()],
    );

    cubitTest<AuthCubit, AuthState>(
      'after registering, AuthNoProfile is emitted',
      build: () async => authCubit,
      act: (cubit) async => cubit.register(email: '', password: ''),
      expect: [AuthLoading()],
    );
  });

  group('AuthCubit initially logged in', () {
    setUp(() {
      final authRepository = MockAuthRepository();

      when(authRepository.getUid).thenAnswer((_) async => 'aaa');
      authCubit = AuthCubit(authRepository: authRepository);
    });

    cubitTest<AuthCubit, AuthState>(
      'Sign out emits AuthNoUser',
      build: () async => authCubit,
      act: (cubit) async => cubit.logout(),
      expect: [AuthNoUser()],
    );
  });
}
