import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/splashScreen.dart';
import 'package:get/get.dart';

import 'authentication/view/loginPage.dart';
import 'main_app/resources/sizeConfig.dart';
import 'main_app/resources/string_resources.dart';

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
      Future.delayed(Duration(seconds: 3),()=> Get.off(LoginPage()));
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
          imageUrl: StringResources.splashScreenImage,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}
