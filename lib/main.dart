import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/authentication/repository/auth_repository.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/splashScreen.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  runApp(App());
}


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(UserDataController());
    Get.put(AuthRepository());
    Get.put(GetSizeConfig());

    return GetMaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: AppConst.magenta,
        accentColor:  AppConst.blue,
      ),
      home: SplashScreen(),
    );
  }
}