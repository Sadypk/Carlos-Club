import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/member/models/demos.dart';
import 'package:flutter_app/utils/appConst.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:get/get.dart';

class AbsentAndPresentListScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Get.arguments,
            style: TextStyle(
                fontSize: sizeConfig.getSize(22),
                fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                onPressed: (){
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.WARNING,
                    animType: AnimType.TOPSLIDE,
                    title: 'Confirm!!',
                    desc: 'Do you want to print a report of ${Get.arguments} ?',
                    btnOkOnPress: (){},
                    btnCancelOnPress: (){}
                  )..show();
                },
                color: Colors.white,
                child: Row(
                  children: [
                    Text(
                      'Print'
                    ),
                    SizedBox(width: sizeConfig.width * 20,),
                    Icon(Icons.print)
                  ],
                ),
              ),
            )
          ],
          bottom: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: TabBar(
              labelColor: AppConst.magenta,
              unselectedLabelColor: Colors.grey[500],
              labelStyle: TextStyle(
                fontSize: sizeConfig.getSize(18),
                fontWeight: FontWeight.bold
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: sizeConfig.getSize(18)
              ),
              tabs: [
                Tab(text: 'Present',),
                Tab(text: 'Absent',),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            presentTab(),
            absentTab(),
          ],
        )
      ),
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
        onTap: (){},
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
        trailing: IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.settings
          ),
        ),
      ),
    );
  }
}
