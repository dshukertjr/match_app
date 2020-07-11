import 'package:app/models/user_public.dart';
import 'package:app/utilities/color.dart';
import 'package:app/widgets/circle_button.dart';
import 'package:app/widgets/swipable_card.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  static const String name = 'SearchTab';

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 12,
                left: 16,
                right: 16,
              ),
              child: SwipableCard(
                onSwipeRight: () {},
                onSwipeLeft: () {},
                userPublic: const UserPublic(
                  uid: 'aaa',
                  name: 'Mike',
                  description:
                      'Love working out on the weekends. Looking for buddies into "working out" with me if you know what I mean ;)',
                  distance: 12,
                  imageUrls: <String>[
                    'https://66.media.tumblr.com/9c6c8faae2312c070d50b295489e1e19/tumblr_pwucvbk3IT1swrlp8o1_400.jpg',
                    'https://i.pinimg.com/originals/f6/c6/0b/f6c60b23077a06f05e1be37726d5b522.jpg',
                    'https://i.pinimg.com/originals/0d/2f/22/0d2f22a0b331ac00275df44a92219352.jpg',
                    'https://usercontent1.hubstatic.com/8628202.jpg',
                    'https://eskipaper.com/images/high-resolution-backgrounds-11.jpg',
                  ],
                ),
              ),
            ),
          ),
          _buttons(context),
        ],
      ),
    );
  }

  Widget _buttons(BuildContext context) {
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
