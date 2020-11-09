import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/general/view_model/profileScreen.dart';
import 'package:flutter_app/member/view/memberCheckInHistory.dart';
import 'package:flutter_app/member/view_model/memberHomeScreen.dart';
import 'package:flutter_app/utils/appConst.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:get/get.dart';

import 'calenderView.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: sizeConfig.height* 500,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: MyClip(),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  MemberHomeScreenViewModel.profilePic
                              ),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ),
                  ClipPath(
                    clipper: MyClip(),
                    child: Container(
                      color: AppConst.magenta.withOpacity(.2),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: sizeConfig.width.value * 60,
                    child: CircleAvatar(
                      radius: sizeConfig.getSize(65),
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: sizeConfig.getSize(60),
                        backgroundImage: CachedNetworkImageProvider(
                            MemberHomeScreenViewModel.profilePic
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: sizeConfig.width * 35
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          ProfileScreenRepo.firstName + '\n' + ProfileScreenRepo.lastName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: sizeConfig.getSize(22),
                          ),
                        ),
                      ),
                      Container(
                        height: sizeConfig.height * 100,
                        color: AppConst.magenta,
                        width: 4,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Get.dialog(Dialog(
                              child: Padding(
                                padding: EdgeInsets.all(sizeConfig.getSize(20)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FlatButton(
                                      onPressed: (){
                                        Get.back();
                                        Get.to(MemberCheckInHistory());
                                      },
                                      color: Colors.grey[300],
                                      child: Text(
                                          'View all'
                                      ),
                                      height: sizeConfig.height * 70,
                                      minWidth: sizeConfig.width * 300,
                                    ),
                                    SizedBox(width: sizeConfig.width * 20,),
                                    FlatButton(
                                      onPressed: (){
                                        Get.back();
                                        Get.dialog(Dialog(child: CalenderView(),));
                                      },
                                      color: Colors.grey[300],
                                      child: Text(
                                          'View calender'
                                      ),
                                      height: sizeConfig.height * 70,
                                      minWidth: sizeConfig.width * 300,
                                    ),
                                  ],
                                ),
                              ),
                            ));
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                '123',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: sizeConfig.getSize(22),
                                    color: AppConst.magenta
                                ),
                              ),
                              Text(
                                  ProfileScreenRepo.checkIn,
                                  style: TextStyle(
                                      fontSize: sizeConfig.getSize(18)
                                  )
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: AppConst.magenta,
                    thickness: 4,
                    height: sizeConfig.height * 30,
                  ),
                  TextField(
                    enabled: false,
                    minLines: 1,
                    maxLines: 2,
                    decoration: InputDecoration(
                        hintText: ProfileScreenRepo.address,
                        hintStyle: TextStyle(
                          color: AppConst.chocolate,
                        ),
                        prefixIcon: Icon(
                          Icons.location_pin,
                          size: sizeConfig.getSize(30),
                          color: AppConst.chocolate,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                        )
                    ),
                  ),
                  TextField(
                    enabled: false,
                    minLines: 1,
                    maxLines: 2,
                    decoration: InputDecoration(
                        hintText: ProfileScreenRepo.email,
                        hintStyle: TextStyle(
                          color: AppConst.chocolate,
                        ),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          size: sizeConfig.getSize(30),
                          color: AppConst.chocolate,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                        )
                    ),
                  ),
                  TextField(
                    enabled: false,
                    minLines: 1,
                    maxLines: 2,
                    decoration: InputDecoration(
                        hintText: ProfileScreenRepo.phone,
                        hintStyle: TextStyle(
                          color: AppConst.chocolate,
                        ),
                        prefixIcon: Icon(
                          Icons.phone_iphone_outlined,
                          size: sizeConfig.getSize(30),
                          color: AppConst.chocolate,
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none
                        )
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          enabled: false,
                          minLines: 1,
                          maxLines: 2,
                          decoration: InputDecoration(
                              hintText: ProfileScreenRepo.facebook,
                              hintStyle: TextStyle(
                                color: AppConst.chocolate,
                              ),
                              prefixIcon: Icon(
                                Icons.api,
                                size: sizeConfig.getSize(30),
                                color: AppConst.chocolate,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          enabled: false,
                          minLines: 1,
                          maxLines: 2,
                          decoration: InputDecoration(
                              hintText: ProfileScreenRepo.instagram,
                              hintStyle: TextStyle(
                                color: AppConst.chocolate,
                              ),
                              prefixIcon: Icon(
                                Icons.api,
                                size: sizeConfig.getSize(30),
                                color: AppConst.chocolate,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              )
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClip extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height * .85);
    path.lineTo(size.width *.3, size.height*.85);
    path.quadraticBezierTo(size.width*.75, size.height*1.1, size.width, size.height*.85);
    // path.lineTo(size.width*.3, size.height);
    // path.lineTo(size.width, size.height*.85);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
