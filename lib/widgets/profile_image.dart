import 'package:app/models/user_public.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage(
    UserPublic userPublic, {
    double size = 50,
    void Function() onPressed,
  })  : _userPublic = userPublic,
        _size = size,
        _onPressed = onPressed;

  final UserPublic _userPublic;
  final double _size;
  final void Function() _onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: GestureDetector(
        onTap: _onPressed,
        child: _userPublic.imageUrls.isEmpty
            ? ClipOval(
                child: Container(),
              )
            : Image.network(
                _userPublic.imageUrls.first,
                width: _size,
                height: _size,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
