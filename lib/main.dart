import 'package:flutter/material.dart';
import 'package:flutter_app/splashScreen.dart';
import 'package:flutter_app/main_app/resources/appConst.dart';
import 'package:get/get.dart';

import 'authentication/models/userType.dart';
import 'main_app/resources/sizeConfig.dart';

main() => runApp(App());

class App extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.put(GetSizeConfig());
  final GetUserType userType = Get.put(GetUserType());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppConst.magenta
      ),
      home: SplashScreen(),
    );
  }
}






//model folder
// class User{
//   String name;
//   User({this.name});
// }


//repository
///backend api calls


//view model
///variables and datas
///auth
// 1.login.dart
// 2.register.dart
// user
// 3.userhomescreen.dart
// 3.1userProfileScreen.dart
// 3.2userCheckinHistory
// admin
// 4.adminHomescreen
// 4.1adminProfile
// 4.2membersCheckinHistory
// 4.3memberAccountdetails
// 4.5myGroup



//view
///screens
//view.widget
///shared widgets