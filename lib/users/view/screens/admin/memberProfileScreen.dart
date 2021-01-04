import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/main_app/util/url_launcher_helper.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:flutter_app/users/view/screens/members/memberCheckInHistory.dart';
import 'package:flutter_app/users/view/widgets/calenderView.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class MemberProfileScreen extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final UserModel member = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final TextEditingController addressController = TextEditingController(text: member.address ?? null);
    final TextEditingController emailControoler = TextEditingController(text: member.email ?? null);
    final  TextEditingController phoneController = TextEditingController(text: member.phoneNumber ?? null);
    final TextEditingController facebookController = TextEditingController(text: member.facebookID ?? null);
    final TextEditingController instaController = TextEditingController(text: member.instagramID ?? null);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
                              image: CachedNetworkImageProvider(member.userPhoto),
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
                      child: Stack(
                        children: [
                          CircleAvatar(
                              radius: sizeConfig.getSize(60),
                              backgroundImage: CachedNetworkImageProvider(member.userPhoto),
                          )  ],
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
                          member.userName??'Loading...',
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
                            Get.dialog(Dialog(child: CalenderView(checkInData: member.checkInData,),));
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                              member.checkInData.isNull? '0':'${member.checkInData.length}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: sizeConfig.getSize(22),
                                    color: AppConst.magenta
                                ),
                              ),
                              Text(
                                  StringResources.checkIn,
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
                    controller: addressController,
                    decoration: InputDecoration(
                        hintText: 'No Address Given',
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
                  GestureDetector(
                    onTap: (){
                      if(emailControoler.text.length > 0){
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.NO_HEADER,
                            title: 'Email ${member.userName}',
                            desc: 'Open email to Send an email to ${member.email} ?',
                            btnCancelOnPress: (){},
                            btnOkOnPress: () async{
                              await UrlLauncherHelper().sendEmail(member.email);
                            }
                        )..show();
                      }
                    },
                    child: TextField(
                      enabled: false,
                      minLines: 1,
                      maxLines: 2,
                      controller: emailControoler,
                      decoration: InputDecoration(
                          hintText: 'No email given',
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
                  ),
                  GestureDetector(
                    onTap: (){
                      if(phoneController.text.length > 0){
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.NO_HEADER,
                            title: 'Call ${member.userName}',
                            desc: 'Make a call to ${member.phoneNumber} ?',
                            btnCancelOnPress: (){},
                            btnOkOnPress: () async{
                              await UrlLauncherHelper().makePhoneCall(member.phoneNumber);
                            }
                        )..show();
                      }
                    },
                    child: TextField(
                      enabled: false,
                      minLines: 1,
                      maxLines: 2,
                      controller: phoneController,
                      decoration: InputDecoration(
                          hintText: 'No phone number given',
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: sizeConfig.width * 30),
                    child: Column(
                      children: [
                        TextFormField(
                          enabled: false,
                          minLines: 1,
                          maxLines: 2,
                          controller: facebookController,
                          decoration: InputDecoration(
                              hintText: StringResources.facebook,
                              // prefix: Text(StringResources.facebookBaseUrl),
                              hintStyle: TextStyle(
                                color: AppConst.chocolate,
                              ),
                              prefixIcon: FaIcon(
                                FontAwesomeIcons.facebookSquare,
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
                          controller: instaController,
                          decoration: InputDecoration(
                              hintText: StringResources.instagram,
                              hintStyle: TextStyle(
                                color: AppConst.chocolate,
                              ),
                              prefixIcon: FaIcon(
                                FontAwesomeIcons.instagramSquare,
                                size: sizeConfig.getSize(30),
                                color: AppConst.chocolate,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                              )
                          ),
                        )
                      ],
                    ),
                  )
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
