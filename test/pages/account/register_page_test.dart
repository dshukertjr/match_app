import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/pages/account/register_page.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:app/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('RegisterPage', () {
    testWidgets('Email Form validation messages are being shown correctly',
        (WidgetTester tester) async {
      final MockAuthRepository authRepository = MockAuthRepository();
      when(authRepository.getUid).thenAnswer((_) async => null);

      await tester.pumpWidget(
        CubitProvider<AuthCubit>(
          create: (_) => AuthCubit(
            authRepository: authRepository,
            initialState: const AuthNoUser(),
          ),
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      /// Press the submit button without entering anything in the text field
      await tester.tap(find.byKey(RegisterPage.registerPageSubmitButtonKey));

      // This will re-render the widget
      await tester.pump();

      // Required field will display error message
      expect(find.text(requiredMessage), findsWidgets);

      // Enter an invalid text into email field
      await tester.enterText(
          find.byKey(RegisterPage.registerPageEmailTextFieldKey),
          'none email text');

      /// Press the submit button without entering anything in the text field
      await tester.tap(find.byKey(RegisterPage.registerPageSubmitButtonKey));

      // This will re-render the widget
      await tester.pump();

      // Email is invalid, so invalid email error message should be shown
      expect(find.text(invalidEmailMessage), findsOneWidget);

      // Enter a valid email address
      await tester.enterText(
          find.byKey(RegisterPage.registerPageEmailTextFieldKey),
          'some@some.com');

      /// Press the submit button without entering anything in the text field
      await tester.tap(find.byKey(RegisterPage.registerPageSubmitButtonKey));

      // This will re-render the widget
      await tester.pump();

      // Email is valid, so no invalid error should be found
      expect(find.text(invalidEmailMessage), findsNothing);
    });

    testWidgets('Password Form validation messages are being shown correctly',
        (WidgetTester tester) async {
      final MockAuthRepository authRepository = MockAuthRepository();
      when(authRepository.getUid).thenAnswer((_) async => null);

      await tester.pumpWidget(
        CubitProvider<AuthCubit>(
          create: (_) => AuthCubit(
            authRepository: authRepository,
            initialState: const AuthNoUser(),
          ),
          child: MaterialApp(
            home: RegisterPage(),
          ),
        ),
      );

      /// Press the submit button without entering anything in the text field
      await tester.tap(find.byKey(RegisterPage.registerPageSubmitButtonKey));

      // This will re-render the widget
      await tester.pump();

      // Required field will display error message
      expect(find.text(requiredMessage), findsWidgets);

      // Enter a password less than 6 letters
      await tester.enterText(
          find.byKey(RegisterPage.registerPagePasswordTextFieldKey), 'aaa');

      /// Press the submit button without entering anything in the text field
      await tester.tap(find.byKey(RegisterPage.registerPageSubmitButtonKey));

      // This will re-render the widget
      await tester.pump();

      // Email is invalid, so invalid email error message should be shown
      expect(find.text(invalidPasswordMessage), findsOneWidget);

      // Enter a valid password
      await tester.enterText(
          find.byKey(RegisterPage.registerPagePasswordTextFieldKey),
          'validPassword');

      /// Press the submit button without entering anything in the text field
      await tester.tap(find.byKey(RegisterPage.registerPageSubmitButtonKey));

      // This will re-render the widget
      await tester.pump();

      // Email is valid, so no invalid error should be found
      expect(find.text(invalidPasswordMessage), findsNothing);
    });
  });
}
