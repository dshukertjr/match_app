import 'package:app/cubits/auth/auth_cubit.dart';
import 'package:app/cubits/prospect/prospect_cubit.dart';
import 'package:app/models/user_public.dart';
import 'package:app/repositories/auth_repository.dart';
import 'package:app/repositories/prospect_repository.dart';
import 'package:app/utilities/color.dart';
import 'package:app/widgets/circle_button.dart';
import 'package:app/widgets/custom_loader.dart';
import 'package:app/widgets/swipable_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cubit/flutter_cubit.dart';

class SwipeTab extends StatefulWidget {
  static const String name = 'SwipeTab';
  static Widget create() {
    return CubitProvider<ProspectCubit>(
      create: (BuildContext context) => ProspectCubit(
        prospectRepository: RepositoryProvider.of<ProspectRepository>(context),
        authRepository: RepositoryProvider.of<AuthRepository>(context),
      )..initialize(),
      child: SwipeTab(),
    );
  }

  @override
  _SwipeTabState createState() => _SwipeTabState();
}

class _SwipeTabState extends State<SwipeTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: _swipeCard(context),
          ),
          _buttons(context),
        ],
      ),
    );
  }

  Padding _swipeCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        left: 16,
        right: 16,
      ),
      child: CubitBuilder<ProspectCubit, ProspectState>(
          builder: (BuildContext context, ProspectState state) {
        if (state is ProspectSuccess) {
          final List<UserPublic> prospects = state.prospects;
          return SwipableCard(
            onSwipeRight: () {
              CubitProvider.of<ProspectCubit>(context).like(prospects.first);
            },
            onSwipeLeft: () {
              CubitProvider.of<ProspectCubit>(context).dislike(prospects.first);
            },
            prospects: prospects,
          );
        } else {
          return Center(
            child: CustomLoader(),
          );
        }
      }),
    );
  }

  Widget _buttons(BuildContext context) {
    return CubitBuilder<ProspectCubit, ProspectState>(
        builder: (BuildContext context, ProspectState state) {
      if (state is ProspectSuccess) {
        // final List<UserPublic> prospects = state.prospects;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _swipeButton(
                iconData: Icons.close,
                color: appRed,
                onPressed: () {},
              ),
              _swipeButton(
                iconData: Icons.favorite,
                color: appGreen,
                onPressed: () {},
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }

  Widget _swipeButton({
    @required IconData iconData,
    @required Color color,
    @required void Function() onPressed,
  }) {
    return CircleButton(
      iconColor: color,
      iconData: iconData,
      onPressed: onPressed,
      shadowColor: appBlue.withOpacity(0.1),
    );
  }
}
