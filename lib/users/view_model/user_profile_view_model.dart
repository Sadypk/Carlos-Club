import 'package:flutter_app/users/models/user_model.dart';
import 'package:get/get.dart';

class UserProfileViewModel{
  var _userModel = UserModel(
    email: 'sadypk19@gmail.com',
    userName: 'Sadypk',
    userType: 'Admin',
  ).obs;

  UserModel get userModel => _userModel.value;

  set userModel(UserModel value) {
    _userModel.value = value;
  }
}