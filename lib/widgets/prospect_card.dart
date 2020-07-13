import 'package:app/models/user_public.dart';
import 'package:app/utilities/color.dart';
import 'package:flutter/material.dart';

class ProspectCard extends StatefulWidget {
  const ProspectCard({Key key, @required UserPublic userPublic})
      : _userPublic = userPublic,
        super(key: key);

  final UserPublic _userPublic;

  @override
  _ProspectCardState createState() => _ProspectCardState();
}

class _ProspectCardState extends State<ProspectCard> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
      ),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ClipPath(
                clipBehavior: Clip.antiAlias,
                clipper: _CardClipper(),
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
                                  (widget._userPublic.imageUrls.length - 1)) {
                                setState(() {
                                  _currentImageIndex++;
                                });
                              }
                            }
                          },
                          child: Image.network(
                            widget._userPublic.imageUrls[_currentImageIndex],
                            fit: BoxFit.cover,
                            loadingBuilder: (_, Widget child,
                                ImageChunkEvent loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              final double progress =
                                  loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes;
                              return Center(
                                child: CircularProgressIndicator(
                                  value: progress,
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
                          children: widget._userPublic.imageUrls.map<Widget>(
                            (String imageUrl) {
                              final bool isActiveIndex = widget
                                      ._userPublic.imageUrls
                                      .indexOf(imageUrl) ==
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
                    widget._userPublic.name,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  const SizedBox(height: 4),
                  Text(widget._userPublic.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyText1),
                  const SizedBox(height: 4),
                  Text(
                    '${widget._userPublic.distance} km away',
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
      ),
    );
  }
}

class _CardClipper extends CustomClipper<Path> {
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
  bool shouldReclip(_CardClipper oldClipper) => true;
}
