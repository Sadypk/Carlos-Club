import 'package:flutter/material.dart';
import 'package:flutter_app/admin/view/adminHomebody.dart';
import 'package:flutter_app/admin/view/groupMembers.dart';
import 'package:flutter_app/general/view/userProfileScreen.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  final GetSizeConfig sizeConfig = Get.find();

  final List<Widget> _pages = [AdminHomeBody(), GroupMembers(), ProfileScreen()];

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
                  Icons.group
              ),
              label: 'Group'
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