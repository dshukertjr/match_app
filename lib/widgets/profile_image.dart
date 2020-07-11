import 'package:app/models/user_private.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage(
    UserPrivate userPrivate, {
    double size = 50,
    void Function() onPressed,
  })  : _userPrivate = userPrivate,
        _size = size,
        _onPressed = onPressed;

  final UserPrivate _userPrivate;
  final double _size;
  final void Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: GestureDetector(
        onTap: _onPressed,
        child: _userPrivate.imageUrls.isEmpty
            ? ClipOval(
                child: Container(),
              )
            : Image.network(
                _userPrivate.imageUrls.first,
                width: _size,
                height: _size,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
