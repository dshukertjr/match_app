import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/models/user_private.dart';
import 'package:app/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('プロフィール編集'),
      ),
      body: SingleChildScrollView(
        child: CubitBuilder<AuthCubit, AuthState>(
          builder: (BuildContext context, AuthState state) {
            if (state is AuthSuccess) {
              final UserPrivate userPrivate = state.userPrivate;
              return Column(
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                      Ink.image(
                        image: NetworkImage(userPrivate.imageUrls.first),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return Center(
                child: CustomLoader(),
              );
            }
          },
        ),
      ),
    );
  }
}
