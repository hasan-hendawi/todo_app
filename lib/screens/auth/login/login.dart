import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/dialog_utils.dart';
import 'package:todo_app/database/fireDataBase.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/provider/settings_provider.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/screens/auth/signup/signup_screen.dart';
import 'package:todo_app/screens/home/home_screen.dart';

import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static const loginRouteName = "LoginScreen";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var globalKey = GlobalKey<FormState>();
  bool showPass = true;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: provider.getAuthBackgroundImage(), fit: BoxFit.fill),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            LocaleKeys.authLogin.tr(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: globalKey,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: height * .3),
                  CustomTextField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.plsEnterEmail.tr();
                      }
                      return null;
                    },
                    controller: emailController,
                    hintText: LocaleKeys.authEmail.tr(),
                    labelText: LocaleKeys.authEmail.tr(),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomTextField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.plsEnterPass;
                      }
                      return null;
                    },
                    onChange: (value) {
                      setState(() {});
                    },
                    showText: showPass,
                    controller: passwordController,
                    hintText: LocaleKeys.authPassword.tr(),
                    labelText: LocaleKeys.authPassword.tr(),
                    suffixIcon: IconButton(
                      icon: Icon(showPass
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () {
                        showPass = !showPass;
                        setState(() {});
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * .1,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(LocaleKeys.authForgetPass.tr()),
                    ),
                  ),
                  SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      login(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: checkFields()
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            LocaleKeys.authLogin.tr(),
                            style: TextStyle(
                                color: checkFields()
                                    ? Colors.white
                                    : Color(0xffBDBDBD)),
                          ),
                          Icon(
                            Icons.arrow_forward_outlined,
                            color: checkFields()
                                ? Colors.white
                                : Color(0xffBDBDBD),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, SignupScreen.signupRouteName);
                    },
                    child: Text(
                      LocaleKeys.authCreateAccount.tr(),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login(BuildContext co) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (globalKey.currentState!.validate()) {
      try {
        DialogUtils.showLoadingDialog(co);
        final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        var user = await FireDataBase.getUser(result.user?.uid ?? '');
        if (user != null) {
          userProvider.setUser(user);
        }
        print(user?.id);
        DialogUtils.hideDialog(co);
        DialogUtils.showMessage(co,
            message: LocaleKeys.loginSuccess.tr(),
            diss: false,
            postActionName: LocaleKeys.ok.tr(), postAction: () {
          Navigator.of(context)
              .pushReplacementNamed(HomeScreen.homeScreenRouteName);
        });
      } on FirebaseAuthException catch (e) {
        DialogUtils.hideDialog(co);
        print("the error is : $e");
        if (e.code == 'invalid-credential') {
          DialogUtils.showMessage(co,
              message: LocaleKeys.wrongPassOrEmail.tr(),
              postActionName: LocaleKeys.ok.tr());
        }
      } catch (e) {
        DialogUtils.hideDialog(co);
        DialogUtils.showMessage(co,
            message: LocaleKeys.somethingWentWrong.tr(),
            postActionName: LocaleKeys.cancel.tr(),
            negActionName: LocaleKeys.tryAgain.tr(), negAction: () {
          login(co);
        });
      }
    }
  }

  bool checkFields() {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }
}
