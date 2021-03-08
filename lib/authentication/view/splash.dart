import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => Splash());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('SPLASH'))
    );
  }
}
