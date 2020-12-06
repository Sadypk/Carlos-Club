import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MemberCheckInHistory extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final UserDataController userDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConst.magenta,
        title: Text(
          StringResources.memberCheckInScreenAppbarText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: sizeConfig.getSize(22)
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: userDataController.userData.value.checkInData.length,
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          vertical: sizeConfig.height * 15,
          horizontal: sizeConfig.width * 30
        ),
        itemBuilder: data,
      ),
    );
  }

  Widget data(BuildContext context, int index) {
    //DemoCheckInModel data = demoCheckInData[index];
    Timestamp timestamp = userDataController.userData.value.checkInData[index];
    return Padding(
      padding:  EdgeInsets.only(
        bottom: sizeConfig.height * 15,
        left: sizeConfig.width * 20,
        right: sizeConfig.width * 20,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('dd MMM yyyy').format(timestamp.toDate()),
            style: TextStyle(
                fontSize: sizeConfig.getSize(18)
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizeConfig.width * 20
              ),
              child: Container(
                color: Colors.grey,
                width: sizeConfig.width * 300,
                height: 2,
              )
          ),
          Text(
              DateFormat().add_jms().format(timestamp.toDate()),
              style: TextStyle(
                  fontSize: sizeConfig.getSize(18),
                  color: Colors.green
              )
          )
        ],
      ),
    );
  }
}
