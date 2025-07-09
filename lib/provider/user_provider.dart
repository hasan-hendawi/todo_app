import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_app/database/models/user_model.dart';
import 'package:todo_app/utils/constants.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _updatedUser;
  var box = Hive.box<UserModel>(Constants.userKey);

  void setUser(UserModel user) {
    box.put(Constants.userBox, user);
    _updatedUser = user;
    notifyListeners();
  }

  void getUser() {
    _updatedUser = box.get(Constants.userBox);
    notifyListeners();
  }

  UserModel? get currentUser => _updatedUser;
}
