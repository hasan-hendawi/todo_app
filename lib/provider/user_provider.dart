import 'package:flutter/material.dart';
import 'package:todo_app/database/models/user_model.dart';

class UserProvider extends ChangeNotifier{
   UserModel? _updatedUser;
   // TaskModel? _updateTask;
   void updateUser(UserModel user){
    _updatedUser=user;
    notifyListeners();
  }
  UserModel? getUser()=>_updatedUser;

   // void updateIsDone(){
   //   _updateTask
   //
   // }
}