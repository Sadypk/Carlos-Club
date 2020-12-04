import 'package:flutter_app/users/models/user_model.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController{
  var userData = UserModel().obs;
  RxBool rememberMe = false.obs;

  setRemember(value)=>rememberMe.value = value;

}
