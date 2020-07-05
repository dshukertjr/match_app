import 'package:app/pages/account/register_page.dart';
import 'package:app/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterPage', () {
    testWidgets('Email Form validation messages are being shown correctly',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RegisterPage(),
        ),
      );

      /// Press the submit button without entering anything in the text field
      await tester.tap(find.byKey(RegisterPage.registerPageSubmitButtonKey));

      // This will re-render the widget
      await tester.pump();

      // Required field will display error message
      expect(find.text(Validator.requiredMessage), findsWidgets);

      // Enter an invalid text into email field
      await tester.enterText(
          find.byKey(RegisterPage.registerPageEmailTextFieldKey),
          'none email text');

      /// Press the submit button without entering anything in the text field
      await tester.tap(find.byKey(RegisterPage.registerPageSubmitButtonKey));

      // This will re-render the widget
      await tester.pump();

      // Email is invalid, so invalid email error message should be shown
      expect(find.text(Validator.invalidEmailMessage), findsOneWidget);

      // Enter a valid email address
      await tester.enterText(
          find.byKey(RegisterPage.registerPageEmailTextFieldKey),
          'some@some.com');

      /// Press the submit button without entering anything in the text field
      await tester.tap(find.byKey(RegisterPage.registerPageSubmitButtonKey));

      // This will re-render the widget
      await tester.pump();

      // Email is valid, so no invalid error should be found
      expect(find.text(Validator.invalidEmailMessage), findsNothing);
    });

    testWidgets('Password Form validation messages are being shown correctly',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: RegisterPage(),
        ),
      );

      /// Press the submit button without entering anything in the text field
      await tester.tap(find.byKey(RegisterPage.registerPageSubmitButtonKey));

      // This will re-render the widget
      await tester.pump();

      // Required field will display error message
      expect(find.text(Validator.requiredMessage), findsWidgets);

      // Enter a password less than 6 letters
      await tester.enterText(
          find.byKey(RegisterPage.registerPagePasswordTextFieldKey), 'aaa');

      /// Press the submit button without entering anything in the text field
      await tester.tap(find.byKey(RegisterPage.registerPageSubmitButtonKey));

      // This will re-render the widget
      await tester.pump();

      // Email is invalid, so invalid email error message should be shown
      expect(find.text(Validator.invalidPasswordMessage), findsOneWidget);

      // Enter a valid password
      await tester.enterText(
          find.byKey(RegisterPage.registerPagePasswordTextFieldKey),
          'validPassword');

      /// Press the submit button without entering anything in the text field
      await tester.tap(find.byKey(RegisterPage.registerPageSubmitButtonKey));

      // This will re-render the widget
      await tester.pump();

      // Email is valid, so no invalid error should be found
      expect(find.text(Validator.invalidPasswordMessage), findsNothing);
    });
  });
}
