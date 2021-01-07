import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/authentication/repository/auth_repository.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/main_app/util/url_launcher_helper.dart';
import 'package:flutter_app/main_app/widgets/isScreenLoading.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:permission_handler/permission_handler.dart';



class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GetSizeConfig sizeConfig = Get.find();

  UserDataController userDataController = Get.find();
  AuthRepository authController = Get.find();

  bool edit = false;
  bool isLoading = false;
  final picker = ImagePicker();
  File image;

  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instaController = TextEditingController();

  @override
  void initState() {
    addressController.text = userDataController.userData.value.address??'';
    phoneController.text = userDataController.userData.value.phoneNumber??'';
    facebookController.text = userDataController.userData.value.facebookID??'';
    instaController.text = userDataController.userData.value.instagramID??'';
    super.initState();
  }

  showDialog(context) {
    Get.dialog(CupertinoAlertDialog(
      title: Text('Camera Permission'),
      content: Text(
          'App requires photo storage permission to access in gallery'),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text('Deny'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        CupertinoDialogAction(
          child: Text('Settings'),
          onPressed: () async {
            var dialogCloser = await openAppSettings();
            if(dialogCloser != null){
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    ));
  }

  void selectPic() async {
    if(await Permission.photos.request().isGranted){
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
        showDialog(context);
        print(e.toString());
      }
    }
    else{
      showDialog(context);
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
    var userData = userDataController.userData.value;
    _handleEditSave() async {
      setState(() {
        edit = !edit;
      });
      if(!edit){
        var data = UserModel(
          userID: userData.userID,
          userGroupID: userData.userGroupID,
          userName: userData.userName,
          email: userData.email,
          userPhoto: userData.userPhoto,
          address: addressController.text,
          phoneNumber: phoneController.text,
          userType: userData.userType,
          userLoginType: userData.userLoginType,
          checkInData: userData.checkInData,
          lastCheckIn: userData.lastCheckIn,
          facebookID: facebookController.text,
          instagramID: instaController.text,
        );
        setState(() {
          isLoading = true;
        });
        var hasException = await authController.updateData(data,image);
        if(hasException ==null){
          getSnackbar('Success','Profile Updated');
        }else{
          getSnackbar('Error',hasException);
        }
        setState(() {
          isLoading = false;
        });
      }
    }

    return SafeArea(
      child: IsScreenLoading(
        isLoading: isLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: _handleEditSave,
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
                              userData.userName??'Loading...',
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
                                    userData.checkInData.isNull? '0':'${userDataController.userData.value.checkInData.length}',
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
                        enabled: edit,
                        minLines: 1,
                        maxLines: 2,
                        controller: addressController,
                        decoration: InputDecoration(
                            hintText: 'Add Address',
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
                            hintText: userData.email??'Loading...',
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
                        enabled: edit,
                        minLines: 1,
                        maxLines: 2,
                        controller: phoneController,
                        decoration: InputDecoration(
                            hintText: 'Add Phone',
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
                      Padding(
                        padding: EdgeInsets.only(left: sizeConfig.width * 30),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: !edit && facebookController.text.isNotEmpty ?(){
                                print(facebookController.text);
                                // UrlLauncherHelper().launchFacebookUrl(facebookController.text);
                              }:(){
                                print(facebookController.text.length);

                              },
                              child: TextFormField(
                                enabled: edit,
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
                            ),
                            InkWell(
                              onTap: !edit && instaController.text.isNotEmpty ?(){
                                UrlLauncherHelper().launchInstagramUrl(instaController.text);
                              }:(){},
                              child: TextField(
                                enabled: edit,
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
