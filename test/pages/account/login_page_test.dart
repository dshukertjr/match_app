import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/pages/account/login_page.dart';
import 'package:app/pages/account/register_page.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:app/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('LoginPage', () {
    testWidgets('Validations are working', (WidgetTester tester) async {
      await tester.pumpWidget(
        CubitProvider<AuthCubit>(
          create: (_) => AuthCubit(
            authRepository: MockAuthRepository(),
            initialState: const AuthNoUser(),
          ),
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      await tester.tap(find.byKey(LoginPage.loginButtonKey));

      await tester.pump();

      expect(find.text(requiredMessage), findsWidgets);
    });

    testWidgets('Register page can be opened from login page',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        CubitProvider<AuthCubit>(
          create: (_) => AuthCubit(
            authRepository: MockAuthRepository(),
            initialState: const AuthNoUser(),
          ),
          child: MaterialApp(
            home: LoginPage(),
          ),
        ),
      );

      await tester.tap(find.byKey(LoginPage.openRegisterPageKey));

      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsNothing);

      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });
}
