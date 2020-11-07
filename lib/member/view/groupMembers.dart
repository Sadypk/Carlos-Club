import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/member/models/demos.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:get/get.dart';

class GroupMembers extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
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
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: sizeConfig.getSize(10),
            mainAxisSpacing: sizeConfig.getSize(10)
        ),
        padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 20, horizontal: sizeConfig.width * 30),
        itemCount: demoGroupMembers.length,
        itemBuilder: userGrid,
      ),
    );
  }

  Widget userGrid(BuildContext context, int index) {
    DemoUsersModel user = demoGroupMembers[index];
    return Card(
      child: GridTile(
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(user.image),
              radius: sizeConfig.getSize(35),
            ),
            RichText(
              text: TextSpan(
                  text: user.fName,
                  style: TextStyle(
                      fontSize: sizeConfig.getSize(18),
                      color: Colors.black
                  ),
                  children: [
                    TextSpan(text: ' '),
                    TextSpan(
                        text: user.lName[0].toUpperCase()
                    )
                  ]
              ),
            )
          ],
        ),
        footer: index ==1 ? Container(
          height: sizeConfig.getSize(10),
          width: sizeConfig.getSize(10),
          color: Colors.red,
        ) : SizedBox(),
      ),
    );
  }
}
