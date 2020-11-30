import 'package:flutter_app/users/models/user_model.dart';

class UserProfileViewModel{
  UserModel _userModel = UserModel(
    email: 'sadypk19@gmail.com',
    userName: 'Sadypk',
    userType: 'Admin',
  );

  UserModel get userModel => _userModel;

  set userModel(UserModel value) {
    _userModel = value;
  }
}