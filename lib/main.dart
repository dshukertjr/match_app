import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/data_providers/auth_provider.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'pages/splash_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final _authProvider = AppAuthProvider();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AppAuthRepository(
            authProvider: _authProvider,
          ),
        ),
      ],
      child: MultiCubitProvider(
        providers: [
          CubitProvider<AuthCubit>(
            create: (context) => AuthCubit(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            )..initialize(),
          ),
        ],
        child: MaterialApp(
          title: 'LGBT Match',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
          ),
          home: SplashPage(),
        ),
      ),
    );
  }
}
