import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/admin/view/adminHomeScreen.dart';
import 'package:flutter_app/general/repository/splashScreen.dart';
import 'package:flutter_app/general/view/loginPage.dart';
import 'package:flutter_app/member/view/memberHomeScreen.dart';
import 'package:flutter_app/utils/getControllers/authController.dart';
import 'package:flutter_app/utils/getControllers/userType.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  GetSizeConfig sizeConfig = Get.find();

  @override
  void initState() {
    if(mounted){
      super.initState();
      Future.delayed(Duration(seconds: 3),()=> Get.off(Root()));
    }else{
      return ;
    }
  }

  @override
  Widget build(BuildContext context) {
    sizeConfig.setConfig(Get.height/1000, Get.width/1000);
    return Scaffold(
      body: Center(
        child: CachedNetworkImage(
          imageUrl: SplashScreenRepo.splashScreenImage,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class Root extends StatelessWidget {
  final AuthController authController = Get.find();
  final GetUserType userType = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx((){
      return (authController.user != null?  //if there is an user
      userType.userType.value == UserType.admin?AdminHomeScreen(): //if user is admin
      userType.userType.value == UserType.admin?MemberHomeScreen() //if user is member
      :LoginPage() // User neither member or admin(SYSTEM ERROR)
          :LoginPage()); //no logged in user
    });
  }
}