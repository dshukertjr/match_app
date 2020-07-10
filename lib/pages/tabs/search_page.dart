import 'package:app/utilities/color.dart';
import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  static const String name = 'SearchTab';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: _card(context),
            ),
          ),
          _buttons(context),
        ],
      ),
    );
  }

  Widget _card(BuildContext context) {
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
              child: Image.network(
                // 'https://66.media.tumblr.com/9c6c8faae2312c070d50b295489e1e19/tumblr_pwucvbk3IT1swrlp8o1_400.jpg',
                'https://i.pinimg.com/originals/f6/c6/0b/f6c60b23077a06f05e1be37726d5b522.jpg',
                fit: BoxFit.cover,
                loadingBuilder:
                    (_, Widget child, ImageChunkEvent loadingProgress) {
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
                  'Mike',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 4),
                Text(
                  'Love working out on the weekends. Looking for buddies into "working out" with me if you know what I mean lol',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: const Color(0xFF777777)),
                ),
                const SizedBox(height: 4),
                Text(
                  '12 km away',
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          DecoratedBox(
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
                      Icons.favorite,
                      color: appGreen,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
