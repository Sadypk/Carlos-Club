import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_app/users/models/demos.dart';
import 'package:get/get.dart';

class MemberCheckInHistory extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
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
        itemCount: demoCheckInData.length,
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
    DemoCheckInModel data = demoCheckInData[index];
    return Card(
      elevation: 1,
      child: ListTile(
        leading: Text(
          (index+1).toString()
        ),
        title: Text(
          data.date
        ),
        subtitle: Text(
          data.time
        ),
      ),
    );
  }
}
