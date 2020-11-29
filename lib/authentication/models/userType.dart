import 'package:get/get.dart';

enum UserType{
  normal,
  admin
}

class GetUserType extends GetxController{
  Rx<UserType> userType = UserType.normal.obs;
  setType(UserType type){
    userType.value = type;
  }
}