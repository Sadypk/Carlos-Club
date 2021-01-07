import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/main_app/widgets/loader.dart';
import 'package:flutter_app/main_app/widgets/logout_dialog.dart';
import 'package:flutter_app/users/repository/groupMemberData.dart';
import 'package:flutter_app/users/repository/homeBodyRepo.dart';
import 'package:flutter_app/users/repository/user_profile_data_repository.dart';
import 'package:flutter_app/users/view/screens/admin/absentAndPresentList.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_app/main_app/widgets/text_field.dart';
import 'package:flutter_app/users/view/widgets/qrScanner.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:permission_handler/permission_handler.dart';

class AdminHomeBody extends StatefulWidget {
  @override
  _AdminHomeBodyState createState() => _AdminHomeBodyState();
}

class _AdminHomeBodyState extends State<AdminHomeBody> {
  final GetSizeConfig sizeConfig = Get.find();
  UserDataController userDataController = Get.find();

  UserProfileDataRepository userProfileDataRepository = UserProfileDataRepository();
  RepoGroupMembers repoGroupMembers = RepoGroupMembers();
  TextEditingController emailController = TextEditingController();
  FocusNode focusNode = FocusNode();


  getData() async{
    await repoGroupMembers.getUngroupedMembers();
  }

  showDialog(context) {
    Get.dialog(CupertinoAlertDialog(
      title: Text('Camera Permission'),
      content: Text(
          'App requires camera permission to scan QR code'),
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

  @override
  void initState() {
    super.initState();
    getData();
    focusNode.addListener(() {setState(() {});});
  }


  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    focusNode.dispose();
  }

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: (){
                userDataController.tabIndex.value = 1;
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: sizeConfig.getSize(4),horizontal: sizeConfig.getSize(10)),
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(userDataController.userData.value.userPhoto??StringResources.memberHomeScreenProfilePic),
                ),
              ),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Welcome: ${userDataController.userData.value.userName}'),
                userDataController.userData.value.userType == 'admin' ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'ADMIN',
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ) : SizedBox()
              ],
            ),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton(
                  child: Icon(Icons.exit_to_app),
                  onSelected: (bool value){
                    if(value){
                      Get.dialog(LogoutDialog());
                    }else{
                    }
                  },
                  itemBuilder: (_){
                    return [
                      PopupMenuItem(
                        value: true,
                        child: Text(
                            'Logout'
                        ),
                      )
                    ];
                  },
                ),
              )
            ],
          ),
          body: loading ? Loader() : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              qrScanners(),
              Row(
                children: [
                  Expanded(
                    child: TabBar(
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
                  FlatButton.icon(
                    color: AppConst.magenta,
                    onPressed: addMember,
                    icon: Icon(Icons.add),
                    label: Text('Add'),
                  ),
                  SizedBox(width: sizeConfig.width * 20,)
                ],
              ),
              AbsentAndPresentListScreen(),
            ],
          ),
        ),
      ),
    );
  }

  Widget qrScanners() {
    return Padding(
      padding: EdgeInsets.all( sizeConfig.height * 20),
      child: FlatButton(
        onPressed: () async{
          if(userDataController.userData.value.userGroupID == ''){
            Get.snackbar('Warning', 'You do not belong to any groups');
          }else{
            // checking last check in
            bool isCheckedIn = await RepoHome.checkLastCheckIn();
            if(isCheckedIn){
              Get.snackbar('Failed', 'You have already checked in today');
            }else{
              if(await Permission.camera.request().isGranted){
                String result = await Get.dialog(QRScanner());
                bool checkCodeException = await userProfileDataRepository.checkCode(result);

                if(checkCodeException){
                  Timestamp timestamp = Timestamp.now();
                  userProfileDataRepository.userCheckIn(userDataController.userData.value.userID,timestamp);
                  checkInSuccessful();
                }else{
                  await userProfileDataRepository.logCheckInFailed(result);
                  checkInFailed();
                }
              }
              else{
                showDialog(context);
              }
            }
          }
        },
        color: AppConst.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 20)),
        minWidth: double.infinity,
        height: sizeConfig.height * 80,
        child: Text(
          StringResources.memberHomeScreenBtnScanQr,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sizeConfig.getSize(28),
              color: Colors.white
          ),
        ),
      ),
    );
  }

  addMember(){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.TOPSLIDE,
        body: StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) ss) {
            return DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(
                    unselectedLabelColor: Colors.grey[500],
                    labelColor: Colors.blue,
                    tabs: [
                      Tab(text: 'Email',),
                      Tab(text: 'List',),
                    ],
                  ),
                  Container(
                    height: sizeConfig.height * 300,
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Enter User Email :',
                                  style: TextStyle(
                                      fontSize: sizeConfig.getSize(24)
                                  ),
                                ),
                                SizedBox(height: sizeConfig.height * 20,),
                                RoundedTextField(
                                    labelText: 'User email',
                                    icon: Icons.email_outlined,
                                    controller: emailController,
                                    focusNode: focusNode,
                                  autoFocus: false,
                                  readOnly: false,
                                )
                              ]
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.zero,
                          itemCount: userDataController.ungroupMemberData.length,
                          itemBuilder: (_, index){
                          var data = userDataController.ungroupMemberData[index];
                              return Card(
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: CachedNetworkImageProvider(
                                      data.userPhoto
                                  ),
                                ),
                                title: Text(
                                    data.userName
                                ),
                                trailing: IconButton(
                                    onPressed: () async{
                                      setState((){
                                        loading = true;
                                      });
                                      var res = await repoGroupMembers.addToGroup(data.userID,userDataController.userData.value.userGroupID);
                                      setState((){
                                        loading = false;
                                      });
                                      if(res == null){
                                        getData();
                                        Get.back();
                                        dialog('Success', '${data.userName} has been added to your group');
                                      }else{
                                        dialog('Failed', res);
                                      }
                                    },
                                    icon: Icon(Icons.add)
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
        btnOkOnPress: () async {
          if(emailController.text.isNotEmpty){
            setState((){
              loading = true;
            });
            var res = await repoGroupMembers.getUserByEmail(emailController.text,userDataController.userData.value.userGroupID);
            setState((){
              loading = false;
            });
            if(res == null){
              getData();
              dialog('Success', '${emailController.text} has been added to your group');
            }else{
              dialog('Failed', res);
            }
          }else{
            Get.snackbar('Attention!', 'Field is empty');
          }

        },

        btnCancelOnPress: ()  {
        }
    )..show();
  }

  dialog(title,desc){
    AwesomeDialog(
        context: context,
        dialogType: title == 'Success' ? DialogType.SUCCES : DialogType.ERROR,
        animType: AnimType.TOPSLIDE,
        title: title,
        desc: desc,
        btnOkOnPress: (){
        },
    )..show();
  }



  void checkInSuccessful() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.TOPSLIDE,
      title: 'Success',
      desc: 'Check In at ${DateFormat('dd MMM').add_jms().format(DateTime.now())}',
      btnOkOnPress: () {},
    )..show();
  }

  void checkInFailed() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Error',
      desc: 'Check In failed',
      btnCancelOnPress: () {},
    )..show();
  }
}