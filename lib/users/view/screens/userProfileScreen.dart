import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/authentication/repository/auth_repository.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';



class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GetSizeConfig sizeConfig = Get.find();

  UserDataController userDataController = Get.find();
  AuthRepository authController = Get.find();

  bool edit = false;
  final picker = ImagePicker();
  File image;


  void selectPic() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }


  getSnackbar(title,hasException){
    Get.snackbar(
      title,
      hasException,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      margin: EdgeInsets.only(left: sizeConfig.width * 10,
          right: sizeConfig.width * 10,
          bottom: sizeConfig.height * 15),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: () async {
                setState(() {
                  edit = !edit;
                });
                if(!edit){
                  var data = UserModel(
                    userID: userDataController.userData.value.userID,
                    userGroupID: userDataController.userData.value.userGroupID,
                    userName: userDataController.userData.value.userName,
                    email: userDataController.userData.value.email,
                    userPhoto: userDataController.userData.value.userPhoto,
                    address: userDataController.userData.value.address,//change
                    phoneNumber: userDataController.userData.value.phoneNumber,//change
                    userType: userDataController.userData.value.userType,
                    userLoginType: userDataController.userData.value.userLoginType,
                    checkInData: userDataController.userData.value.checkInData,
                    lastCheckIn: userDataController.userData.value.lastCheckIn,
                    facebookID: userDataController.userData.value.facebookID,
                    instagramID: userDataController.userData.value.instagramID,
                  );
                  var hasException = await authController.updateData(data,image);
                  if(hasException ==null){
                    setState(() {
                      getSnackbar('Success','Profile Updated');
                    });
                  }else{
                    getSnackbar('Error',hasException);
                  }
                }
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
              color: Colors.grey[400],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    edit ? Icons.save : Icons.edit,
                    color: Colors.white,
                    size: sizeConfig.getSize(20),
                  ),
                  SizedBox(width: sizeConfig.width * 10,),
                  Text(
                    edit ? 'Save' : 'Edit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: sizeConfig.getSize(18)
                    ),
                  )
                ],
              ),
            ),
          )
        ],
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
                              image: CachedNetworkImageProvider(userDataController.userData.value.userPhoto??StringResources.memberHomeScreenProfilePic),
                             // image: image == null ? CachedNetworkImageProvider(userDataController.userData.value.userPhoto??MemberHomeScreenViewModel.profilePic) : FileImage(image),
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
                            backgroundImage: image == null ? CachedNetworkImageProvider(userDataController.userData.value.userPhoto??StringResources.memberHomeScreenProfilePic) : FileImage(image)),
                          if (edit) Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: selectPic,
                              child: CircleAvatar(
                                radius: sizeConfig.getSize(20),
                                backgroundColor: Colors.white60,
                                child: Icon(
                                  Icons.camera
                                ),
                              ),
                            ),
                          ) else SizedBox(),
                        ],
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
                          userDataController.userData.value.userName??'Loading...',
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
                            /*Get.dialog(Dialog(
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
                            ));*/
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                userDataController.userData.value.checkInData.isNull? '0':'${userDataController.userData.value.checkInData.length}',
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
                    decoration: InputDecoration(
                        hintText: userDataController.userData.value.address??'Add Address',
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
                        hintText: userDataController.userData.value.email??'Loading...',
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
                        hintText: userDataController.userData.value.phoneNumber??'Add Phone',
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
                              hintText: StringResources.facebook,
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
                              hintText: StringResources.instagram,
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
