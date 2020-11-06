import 'package:flutter/material.dart';
import 'package:flutter_app/member/models/demos.dart';
import 'package:flutter_app/member/view_model/memberCheckInHistory.dart';
import 'package:flutter_app/utils/appConst.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:get/get.dart';

class MemberCheckInHistory extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConst.magenta,
        title: Text(
          MemberCheckInHistoryViewModel.appbarText,
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
