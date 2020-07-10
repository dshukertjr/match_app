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
    final AuthProvider _authProvider = AuthProvider();
    final FirestoreProvider _firestoreProvider = FirestoreProvider();
    final StorageProvider _storageProvider = StorageProvider();
    return MultiRepositoryProvider(
      providers: <RepositoryProvider<Object>>[
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(
            authProvider: _authProvider,
            firestoreProvider: _firestoreProvider,
            storageProvider: _storageProvider,
          ),
        ),
      ],
      child: MultiCubitProvider(
        // ignore: always_specify_types
        providers: <CubitProvider>[
          CubitProvider<AuthCubit>(
            create: (BuildContext context) => AuthCubit(
              authRepository: RepositoryProvider.of<AuthRepository>(context),
            )..initialize(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LGBT Match',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFFdaeef3),
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
          ),
          home: SplashPage(),
        ),
      ),
    );
  }
}
