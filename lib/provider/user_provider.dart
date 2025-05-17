import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/database/models/user_model.dart';
import 'package:todo_app/utils/constants.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _updatedUser;

  void setUser(UserModel user) async {
    var shared = await SharedPreferences.getInstance();
    //chat
    bool success = await shared.setString(Constants.userKey, json.encode(user.toJson()));
    if (success) {
      _updatedUser = user;
      notifyListeners();
    } else {
      print("cant set the user from the user provider");
    }
  }

  Future<void> getUser() async {
    final shared = await SharedPreferences.getInstance();
    String? userString = shared.getString(Constants.userKey);
    if (userString != null && userString.isNotEmpty) {
      _updatedUser = UserModel.fromJson(json.decode(userString));
    }  notifyListeners();
  }

  UserModel? get currentUser => _updatedUser;
}
