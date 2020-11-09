import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/admin/models/demos.dart';
import 'package:flutter_app/admin/view/absentAndPresentList.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:get/get.dart';

class GroupCheckInHistory extends StatelessWidget {
  final GetSizeConfig sizeConfig  = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Group name',
          style: TextStyle(
              fontSize: sizeConfig.getSize(22),
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: demoGroupCheckInData.length,
        padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 30, vertical: sizeConfig.height * 15),
        itemBuilder: item,
      ),
    );
  }

  Widget item(BuildContext context, int index) {
    DemoGroupCheckIn data = demoGroupCheckInData[index];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(sizeConfig.width * 20)),
      child: ListTile(
        onTap: (){
          Get.to(AbsentAndPresentListScreen(),arguments: data.date);
        },
        title: Text(
          data.date
        ),
        trailing: RichText(
          text: TextSpan(
            text: '${data.present}',
            style: TextStyle(
              color: Colors.green
            ),
            children: [
              TextSpan(
                text: ' / ',
                style: TextStyle(
                  color: Colors.black
                )
              ),
              TextSpan(
                text: '${data.absent}',
                style: TextStyle(
                  color: Colors.red
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}
