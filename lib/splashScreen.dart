import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/authentication/view/login_page.dart';
import 'package:flutter_app/authentication/repository/auth_repository.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/users/models/userSessionModel.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:flutter_app/users/repository/user_profile_data_repository.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  GetStorage localStorage = GetStorage();
  AuthRepository authController = Get.find();
  UserDataController userDataController = Get.find();
  GetSizeConfig getSizeConfig = Get.find();

  @override
  void initState() {
    if (!mounted) {
      return;
    } else {
      super.initState();
      initiateSize();
      checkSession();
    }
  }

  initiateSize() {
    getSizeConfig.setConfig(Get.height / 1000, Get.width / 1000);
  }

  checkSession() {
    print('Checking session...');
    print(localStorage.read('userValues'));
    bool session = localStorage.hasData('userValues');
    if (session) {
      userDataController.sessionData.value = UserSessionModel.fromJson(localStorage.read('userValues'));
      UserProfileDataRepository().getUserData(userDataController.sessionData.value.email,userDataController.sessionData.value.userLoginType,true);

      Future.delayed(Duration(seconds: 3), () => authController.sessionTypeIdentifier());
    } else {
      print('Session Availability: $session');
      Future.delayed(Duration(seconds: 3), () => Get.off(LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(size: 300,)
      ),
    );
  }
}
