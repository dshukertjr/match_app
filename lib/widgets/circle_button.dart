import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  const CircleButton({
    Key key,
    @required IconData iconData,
    Color shadowColor = const Color(0x11000000),
    @required Color iconColor,
    @required void Function() onPressed,
  })  : _iconData = iconData,
        _shadowColor = shadowColor,
        _iconColor = iconColor,
        _onPressed = onPressed,
        super(key: key);

  final IconData _iconData;
  final Color _shadowColor;
  final Color _iconColor;
  final void Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _shadowColor,
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
            onTap: _onPressed,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                _iconData,
                color: _iconColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
