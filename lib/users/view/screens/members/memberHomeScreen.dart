import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/users/view/screens/userProfileScreen.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';
import 'homeBody.dart';

class MemberHomeScreen extends StatefulWidget {
  @override
  _MemberHomeScreenState createState() => _MemberHomeScreenState();
}

class _MemberHomeScreenState extends State<MemberHomeScreen> {

  final GetSizeConfig sizeConfig = Get.find();

  final List<Widget> _pages = [HomeBody(),ProfileScreen()];

  UserDataController userDataController = Get.find();


  @override
  Widget build(BuildContext context) {
    return Obx((){
      return SafeArea(
        child: Scaffold(
          body: IndexedStack(
            children: _pages,
            index: userDataController.tabIndex.value,
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (i){
              userDataController.tabIndex.value = i;
            },
            currentIndex: userDataController.tabIndex.value,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.home
                  ),
                  label: 'Home'
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.person
                  ),
                  label: 'Profile'
              ),
            ],
          ),
        ),
      );
    });
  }

}