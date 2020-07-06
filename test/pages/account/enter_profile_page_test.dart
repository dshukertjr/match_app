import 'package:app/blocs/auth/auth_bloc.dart';
import 'package:app/pages/account/enter_profile_page.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:app/utilities/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('EnterProfilePage', () {
    testWidgets('Validations are working', (tester) async {
      await tester.pumpWidget(
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: MockAuthRepository(),
            initialState: AuthNoUser(),
          ),
          child: MaterialApp(
            home: EnterProfilePage(),
          ),
        ),
      );

      await tester
          .tap(find.byKey(EnterProfilePage.enterProfilePageSubmitButtonKey));

      await tester.pump();

      expect(find.text(Validator.requiredMessage), findsWidgets);
    });
  });
}
