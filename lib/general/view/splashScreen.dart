import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/general/repository/splashScreen.dart';
import 'package:flutter_app/general/view/loginPage.dart';
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
          imageUrl: SplashScreenRepo.splashScreenImage,
          // fit: BoxFit.cover,
        ),
      ),
    );
  }
}
