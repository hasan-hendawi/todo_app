import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/provider/settings_provider.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/screens/auth/login/login.dart';
import 'package:todo_app/screens/auth/signup/signup_screen.dart';
import 'package:todo_app/screens/home/home_screen.dart';
import 'package:todo_app/screens/splash/splash_screen.dart';
import 'package:todo_app/theme/my_theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
      ],
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: provider.mode,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.splashRouteName,
      routes: {
        SplashScreen.splashRouteName: (context) => SplashScreen(),
        SignupScreen.signupRouteName: (context) => SignupScreen(),
        LoginScreen.loginRouteName: (context) => LoginScreen(),
        HomeScreen.homeScreenRouteName: (context) => HomeScreen(),
      },
    );
  }
}
