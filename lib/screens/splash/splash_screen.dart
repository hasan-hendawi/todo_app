import 'package:flutter/material.dart';
import 'package:todo_app/screens/auth/login/login.dart';

class SplashScreen extends StatelessWidget {
  static const splashRouteName = "/";

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
        Duration(seconds: 2),
        () => Navigator.of(context)
            .pushReplacementNamed(LoginScreen.loginRouteName));

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Image.asset("assets/images/logo.png"),
    );
  }
}
