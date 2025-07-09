import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/screens/auth/login/login.dart';
import 'package:todo_app/screens/home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const splashRouteName = "/";

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  // Method to check if user exists in SharedPreferences
  _checkUser() async {

    // Wait for a brief moment to simulate splash screen
    await Future.delayed(Duration(seconds: 2), ()  {
        // If user data exists, load user data and navigate to the main screen
      var userProvider=Provider.of<UserProvider>(context, listen: false);
      userProvider.getUser();

        if (userProvider.currentUser!=null) {

          Navigator.pushReplacementNamed(context,
              HomeScreen.homeScreenRouteName);
        } else {
        // If user data doesn't exist, navigate to the login screen
          Navigator.pushReplacementNamed(
              context, LoginScreen.loginRouteName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Image.asset("assets/images/logo.png"),
    );
  }
}
