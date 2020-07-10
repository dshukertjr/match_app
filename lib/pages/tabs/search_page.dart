import 'package:app/models/user_public.dart';
import 'package:app/utilities/color.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  static const String name = 'SearchTab';

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  int _currentImageIndex = 0;

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
              child: _card(
                context: context,
                userPublic: const UserPublic(
                  name: 'Mike',
                  description:
                      'Love working out on the weekends. Looking for buddies into "working out" with me if you know what I mean ;)',
                  distance: 12,
                  imageUrls: <String>[
                    'https://66.media.tumblr.com/9c6c8faae2312c070d50b295489e1e19/tumblr_pwucvbk3IT1swrlp8o1_400.jpg',
                    'https://i.pinimg.com/originals/f6/c6/0b/f6c60b23077a06f05e1be37726d5b522.jpg',
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

  Widget _card(
      {@required BuildContext context, @required UserPublic userPublic}) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: appBlue.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ClipPath(
              clipBehavior: Clip.antiAlias,
              clipper: CardClipper(),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return GestureDetector(
                        onTapDown: (TapDownDetails details) {
                          final bool tappedLeftHalf =
                              (details.localPosition.dx /
                                      constraints.maxWidth) <
                                  0.5;
                          if (tappedLeftHalf) {
                            if (_currentImageIndex > 0) {
                              setState(() {
                                _currentImageIndex--;
                              });
                            }
                          } else {
                            if (_currentImageIndex <
                                (userPublic.imageUrls.length - 1)) {
                              setState(() {
                                _currentImageIndex++;
                              });
                            }
                          }
                        },
                        child: Image.network(
                          userPublic.imageUrls[_currentImageIndex],
                          fit: BoxFit.cover,
                          loadingBuilder: (_, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (child != null) {
                              return child;
                            }
                            return const Center(
                              child: CircularProgressIndicator(
                                value: 0.3,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                  Positioned(
                      top: 12,
                      left: 12,
                      right: 12,
                      child: Row(
                        children: userPublic.imageUrls.map<Widget>(
                          (String imageUrl) {
                            final bool isActiveIndex =
                                userPublic.imageUrls.indexOf(imageUrl) ==
                                    _currentImageIndex;
                            final Color color = isActiveIndex
                                ? Colors.white
                                : Colors.white.withOpacity(0.4);
                            return Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                height: 4,
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  userPublic.name,
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 4),
                Text(
                  userPublic.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: const Color(0xFF777777)),
                ),
                const SizedBox(height: 4),
                Text(
                  '${userPublic.distance} km away',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: const Color(0xFFAAAAAA)),
                ),
              ],
            ),
          ),
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
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: appBlue.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Material(
          color: Colors.white,
          child: InkResponse(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                iconData,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 0.9);
    path.relativeQuadraticBezierTo(
        0, size.height * 0.1, -size.width, size.height * 0.1);
    return path;
  }

  @override
  bool shouldReclip(CardClipper oldClipper) => true;
}
