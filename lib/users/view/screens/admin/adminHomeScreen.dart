import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/users/repository/groupMemberData.dart';
import 'package:flutter_app/users/view/screens/admin/adminHomebody.dart';
import 'package:flutter_app/users/view/screens/userProfileScreen.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  final GetSizeConfig sizeConfig = Get.find();

  final List<Widget> _pages = [AdminHomeBody(), ProfileScreen()];

  UserDataController userDataController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>SafeArea(
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
    ));
  }

}