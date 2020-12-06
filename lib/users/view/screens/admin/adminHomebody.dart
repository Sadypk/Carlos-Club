import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/main_app/widgets/loader.dart';
import 'package:flutter_app/main_app/widgets/logout_dialog.dart';
import 'package:flutter_app/users/repository/groupMemberData.dart';
import 'package:flutter_app/users/repository/user_profile_data_repository.dart';
import 'package:flutter_app/users/view/screens/admin/absentAndPresentList.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_app/main_app/widgets/text_field.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.symmetric(vertical: sizeConfig.getSize(4),horizontal: sizeConfig.getSize(10)),
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(userDataController.userData.value.userPhoto??StringResources.memberHomeScreenProfilePic),
            ),
          ),
          title: Text('Welcome: ${userDataController.userData.value.userName}'),
          elevation: 0,
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
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: addMember,
                  color: Colors.green,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add,color: Colors.white,),
                      Text('Add User',style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              )
            ],
          ),
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
        body: loading ? Loader() : AbsentAndPresentListScreen(),
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
}