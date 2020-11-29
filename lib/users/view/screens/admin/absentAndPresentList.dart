import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/sizeConfig.dart';
import 'package:flutter_app/users/models/demos.dart';
import 'package:get/get.dart';
import 'groupMemberDetails.dart';

class AbsentAndPresentListScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return TabBarView(
      children: [
        presentTab(),
        absentTab(),
      ],
    );
  }

  presentTab(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: demoGroupMembers.length,
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 30, vertical: sizeConfig.height * 15),
      itemBuilder: item,
    );
  }

  absentTab(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 7,
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 30, vertical: sizeConfig.height * 15),
      itemBuilder: item,
    );
  }
  
  Widget item(BuildContext context, int index) {
    DemoUsersModel data = demoGroupMembers[index];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(sizeConfig.width * 20)),
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        onTap: (){Get.to(GroupMemberDetailsScreen(), arguments: data);},
        leading: CircleAvatar(
          radius: sizeConfig.getSize(30),
          backgroundImage: CachedNetworkImageProvider(
            data.image
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: data.fName,
                  style: TextStyle(
                      color: Colors.black,
                    fontSize: sizeConfig.getSize(18),
                    fontWeight: FontWeight.normal
                  ),
                  children: [
                    TextSpan(
                        text: ' ',
                    ),
                    TextSpan(
                        text: data.lName,
                    )
                  ]
              ),
            ),
            data.admin ? Text(
              'Admin',
              style: TextStyle(color: Colors.red),
            ) : SizedBox()
          ],
        ),
      ),
    );
  }
}
