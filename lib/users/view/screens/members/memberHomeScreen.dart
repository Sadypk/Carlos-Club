import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/sizeConfig.dart';
import 'package:flutter_app/users/view/screens/userProfileScreen.dart';
import 'package:get/get.dart';
import 'homeBody.dart';

class MemberHomeScreen extends StatefulWidget {
  @override
  _MemberHomeScreenState createState() => _MemberHomeScreenState();
}

class _MemberHomeScreenState extends State<MemberHomeScreen> {

  final GetSizeConfig sizeConfig = Get.find();

  final List<Widget> _pages = [HomeBody(),ProfileScreen()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: _pages,
        index: index,
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i){
          setState(() {
            index = i;
          });
        },
        currentIndex: index,
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
    );
  }

}