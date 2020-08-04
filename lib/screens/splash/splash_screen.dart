import 'package:flutter/material.dart';

/*
  Displays application logo in full screen.
*/
class SplashPage extends StatelessWidget {
  const SplashPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: AnimatedContainer(
        child: Image.asset("assets/newspaper.png"),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      )),
    );
  }
}
