import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/common/dialog_utils.dart';
import 'package:todo_app/database/fireDataBase.dart';
import 'package:todo_app/database/models/user_model.dart';
import 'package:todo_app/generated/locale_keys.g.dart';
import 'package:todo_app/provider/settings_provider.dart';
import 'package:todo_app/provider/user_provider.dart';
import 'package:todo_app/screens/auth/widgets/custom_text_field.dart';
import 'package:todo_app/screens/home/home_screen.dart';
import 'package:todo_app/utils/validation.dart';

class SignupScreen extends StatefulWidget {
  static const signupRouteName = "/SignupScreen";

  SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  ThemeMode mode = ThemeMode.light;

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
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
          image: provider.getAuthBackgroundImage(),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            LocaleKeys.authCreateAccount.tr(),
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
                    controller: firstNameController,
                    hintText: LocaleKeys.authFname.tr(),
                    labelText: LocaleKeys.authFname.tr(),
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.plsEnterName.tr();
                      }
                      if (value.length < 2 || value.length > 15) {
                        return LocaleKeys.plsEnterCorrectName.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomTextField(
                    controller: emailController,
                    hintText: LocaleKeys.authEmail.tr(),
                    labelText: LocaleKeys.authEmail.tr(),
                    validate: (val) {
                      if (val == null || val.isEmpty)
                        return LocaleKeys.plsEnterEmail.tr();
                      if (!Validation.emailValid(val)) return "wrong email";
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  CustomTextField(
                    validate: (value) {
                      if (value != null) {
                        if (value.length < 8) {
                          return LocaleKeys.passTooShort.tr();
                        }
                      }
                      if (value == null || value.isEmpty) {
                        return LocaleKeys.required.tr();
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
                  ElevatedButton(
                      onPressed: () {
                        register(context);
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
                              LocaleKeys.authCreateAccount.tr(),
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
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void register(BuildContext context) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    if (globalKey.currentState!.validate()) {
      DialogUtils.showLoadingDialog(context);
      try {
        final result =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var user = UserModel(
          id: result.user?.uid,
          name: firstNameController.text,
          email: emailController.text,
        );
        await FireDataBase.addUser(user);
        userProvider.setUser(user);
        DialogUtils.hideDialog(context);

        DialogUtils.showMessage(context,
            message: LocaleKeys.userRegisteredSuccess.tr(),
            diss: false,
            postActionName: LocaleKeys.ok.tr(), postAction: () {
          Navigator.of(context)
              .pushReplacementNamed(HomeScreen.homeScreenRouteName );
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  bool checkFields() {
    return emailController.text.isNotEmpty &&
        firstNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }
}
