import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/models/user_private.dart';
import 'package:app/pages/account/edit_profile_page.dart';
import 'package:app/utilities/navitate_on_auth_state_change.dart';
import 'package:app/widgets/adaptive_dialog.dart';
import 'package:app/widgets/circle_button.dart';
import 'package:app/widgets/list_tile_white.dart';
import 'package:app/widgets/profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cubit/flutter_cubit.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:package_info/package_info.dart';

class AccountTab extends StatelessWidget {
  static const String name = 'AccountTab';

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: ListView(
        children: <Widget>[
          const SizedBox(height: 48),
          CubitBuilder<AuthCubit, AuthState>(
              builder: (BuildContext context, AuthState state) {
            if (state is AuthSuccess) {
              final UserPrivate userPrivate = state.userPrivate;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
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
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CircleButton(
                          iconData: Feather.settings,
                          iconColor: const Color(0xFFcdcdcd),
                          onPressed: () {},
                        ),
                        CircleButton(
                          iconData: Feather.edit_2,
                          iconColor: const Color(0xFFcdcdcd),
                          onPressed: () {
                            Navigator.of(context)
                                .push<void>(EditProfilePage.route());
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
            return Container();
          }),
          const SizedBox(height: 24),
          const Divider(),
          ListTileWhite(
            title: '利用規約',
            onPressed: () {},
          ),
          const Divider(),
          ListTileWhite(
            title: 'プライバシーポリシー',
            onPressed: () {},
          ),
          const Divider(),
          ListTileWhite(
            title: 'このアプリについて',
            onPressed: () async {
              final PackageInfo packageInfo = await PackageInfo.fromPlatform();
              final String appName = packageInfo.appName;
              final String version = packageInfo.version;
              showAboutDialog(
                routeSettings: const RouteSettings(name: 'aboutDialog'),
                context: context,
                applicationName: appName,
                applicationVersion: version,
                children: <Widget>[
                  const Text(
                    'このアプリケーションは性的指向に関係なく恋愛を楽しんでもらうためのマッチングサービスを提供するアプリケーションです。',
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              );
            },
          ),
          const Divider(),
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
      ),
    );
  }

  void _signOut(BuildContext context) {
    final AuthCubit authCubit = CubitProvider.of<AuthCubit>(context);
    showDialog<void>(
      context: context,
      builder: (_) => CubitListener<AuthCubit, AuthState>(
        cubit: authCubit,
        listener: navigateOnAuthStateChange,
        child: AdaptiveDialog(
          title: 'ログアウトしてもよろしいですか？',
          confirmLabel: 'ログアウト',
          confirmOnPressed: () {
            CubitProvider.of<AuthCubit>(context).logout();
          },
        ),
      ),
    );
  }
}
