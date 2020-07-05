import 'package:app/pages/welcome/register_page.dart';
import 'package:app/utilities/validator.dart';
import 'package:e2e/e2e.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  E2EWidgetsFlutterBinding.ensureInitialized();

  testWidgets("failing test example", (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: RegisterPage(),
      ),
    );

    await tester.tap(find.byKey(RegisterPage.submitButtonKey));

    // This will re-render the widget
    await tester.pump();

    // Required field will display error message
    expect(find.text(Validator.requiredMessage), findsWidgets);

    // Enter an invalid text into email field
    await tester.enterText(
        find.byKey(RegisterPage.emailTextFieldKey), 'none email text');

    /// Press the submit button without entering anything in the text field
    await tester.tap(find.byKey(RegisterPage.submitButtonKey));

    // This will re-render the widget
    await tester.pump();

    // Email is invalid, so invalid email error message should be shown
    expect(find.text(Validator.invalidEmailMessage), findsOneWidget);

    // Enter a valid email address
    await tester.enterText(
        find.byKey(RegisterPage.emailTextFieldKey), 'some@some.com');

    /// Press the submit button without entering anything in the text field
    await tester.tap(find.byKey(RegisterPage.submitButtonKey));

    // This will re-render the widget
    await tester.pump();

    // Email is valid, so no invalid error should be found
    expect(find.text(Validator.invalidEmailMessage), findsNothing);
  });
}
