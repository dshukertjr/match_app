import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/pages/account/enter_profile_page.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:app/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('EnterProfilePage', () {
    testWidgets('Validations are working', (WidgetTester tester) async {
      await tester.pumpWidget(
        CubitProvider<AuthCubit>(
          create: (_) => AuthCubit(
            authRepository: MockAuthRepository(),
            initialState: const AuthNoUser(),
          ),
          child: MaterialApp(
            home: EnterProfilePage(),
          ),
        ),
      );

      await tester.tap(find.byKey(EnterProfilePage.pageSubmitButtonKey));

      await tester.pump();

      expect(find.text(requiredMessage), findsWidgets);
    });

    testWidgets('page controller works as expected',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        CubitProvider<AuthCubit>(
          create: (_) => AuthCubit(
            authRepository: MockAuthRepository(),
            initialState: const AuthNoUser(),
          ),
          child: MaterialApp(
            home: EnterProfilePage(),
          ),
        ),
      );

      // enter name, birthdate and press next
      await tester.enterText(
          find.byKey(EnterProfilePage.nameTextFieldKey), 'aaa');

      await tester.tap(find.byKey(EnterProfilePage.birthDateTextFieldKey));

      await tester.pumpAndSettle();

      // await tester.tap(find.byType(CupertinoButton));
      await tester.tap(find.text('完了'));

      await tester.pump();

      await tester.tap(find.byKey(EnterProfilePage.pageSubmitButtonKey));

      await tester.pumpAndSettle();

      expect(find.byKey(EnterProfilePage.pageSexualOrientationKey),
          findsOneWidget);

      // choose sexual orientation and press next

      await tester.tap(find.byKey(EnterProfilePage.pageSexualOrientationKey));

      await tester.tap(find.byKey(EnterProfilePage.pageSubmitButtonKey));

      await tester.pumpAndSettle();

      expect(find.byKey(EnterProfilePage.pageWantSexualOrientationKey),
          findsOneWidget);
    });
  });
}
