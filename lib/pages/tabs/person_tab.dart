import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/models/user_private.dart';
import 'package:app/widgets/adaptive_dialog.dart';
import 'package:app/widgets/list_tile_white.dart';
import 'package:app/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class PersonTab extends StatelessWidget {
  static const String name = 'PersonTab';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(height: 48),
        CubitBuilder<AuthCubit, AuthState>(
            builder: (BuildContext context, AuthState state) {
          if (state is AuthSuccess) {
            final UserPrivate userPrivate = state.userPrivate;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: ProfileImage(
                    userPrivate,
                    size: 100,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  userPrivate.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 12),
                Text(userPrivate.description ?? '',
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            );
          }
          return Container();
        }),
        const SizedBox(height: 48),
        const Divider(),
        ListTileWhite(
          title: 'ログアウト',
          onPressed: () {
            _signOut(context);
          },
        ),
        const Divider(),
      ],
    );
  }

  void _signOut(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AdaptiveDialog(
        title: 'ログアウトしてもよろしいですか？',
        confirmLabel: 'ログアウト',
        confirmOnPressed: () {
          CubitProvider.of<AuthCubit>(context).logout();
        },
      ),
    );
  }
}
