import 'package:app/widgets/custom_loader.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomLoader(),
      ),
    );
  }
}
