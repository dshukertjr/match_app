import 'package:app/repositories/auth_repository.dart';
import 'package:app/utilities/color.dart';
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
            dividerTheme: const DividerThemeData(
              space: 1,
              color: Color(0xFF999999),
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              color: Colors.white,
              textTheme: TextTheme(
                headline6: TextStyle(
                  color: appBlue,
                  fontSize: 12,
                ),
              ),
              iconTheme: IconThemeData(
                color: appBlue,
              ),
            ),
            scaffoldBackgroundColor: const Color(0xFFF3F9FB),
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(),
            ),
            textTheme: const TextTheme(
              bodyText1: TextStyle(
                fontSize: 14,
                color: Color(0xFF777777),
              ),
            ),
          ),
          home: SplashPage(),
        ),
      ),
    );
  }
}
