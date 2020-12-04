import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/users/view/screens/admin/adminHomebody.dart';
import 'package:flutter_app/users/view/screens/userProfileScreen.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatefulWidget {
  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  final GetSizeConfig sizeConfig = Get.find();

  final List<Widget> _pages = [AdminHomeBody(), ProfileScreen()];

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