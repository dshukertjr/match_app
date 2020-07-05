import 'package:app/pages/account/login_page.dart';
import 'package:app/pages/account/register_page.dart';
import 'package:app/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginPage', () {
    testWidgets('Validations are working', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginPage(),
        ),
      );

      await tester.tap(find.byKey(LoginPage.loginButtonKey));

      await tester.pump();

      expect(find.text(Validator.requiredMessage), findsWidgets);
    });

    testWidgets('Register page can be opened from login page', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginPage(),
        ),
      );

      await tester.tap(find.byKey(LoginPage.openRegisterPageKey));

      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsNothing);

      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });
}
