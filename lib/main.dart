import 'package:app/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

import 'cubits/auth/auth_cubit.dart';
import 'data_providers/auth_provider.dart';
import 'data_providers/firestore_provider.dart';
import 'data_providers/storage_provider.dart';
import 'pages/splash_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _authProvider = AuthProvider();
    final _firestoreProvider = FirestoreProvider();
    final _storageProvider = StorageProvider();
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            authProvider: _authProvider,
            firestoreProvider: _firestoreProvider,
            storageProvider: _storageProvider,
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
