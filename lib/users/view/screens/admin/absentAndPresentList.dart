import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:flutter_app/users/repository/groupMemberData.dart';
import 'package:flutter_app/users/repository/user_profile_data_repository.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'groupMemberDetails.dart';

class AbsentAndPresentListScreen extends StatefulWidget {


  @override
  _AbsentAndPresentListScreenState createState() => _AbsentAndPresentListScreenState();
}

class _AbsentAndPresentListScreenState extends State<AbsentAndPresentListScreen> {
  final GetSizeConfig sizeConfig = Get.find();
  UserDataController userDataController = Get.find();

  UserProfileDataRepository userProfileDataRepository = UserProfileDataRepository();
  RepoGroupMembers repoGroupMembers = RepoGroupMembers();

  List<UserModel> presentUser = [];

  List<UserModel> absentUser = [];

  bool loading = true;
  getData() async{
    setState(() {
      loading = true;
    });
    await repoGroupMembers.getGroupMemberData();
    absentUser.clear();
    presentUser.clear();
    userDataController.groupMemberData.forEach((user) {
      user.checkInData.forEach((checkIn) {
        if(DateFormat('dd-MM-yy').format(DateTime.now()) == DateFormat('dd-MM-yy').format(checkIn.toDate())){
          presentUser.add(user);
        }
      });
    });
    absentUser.addAll(userDataController.groupMemberData.where((element) => !presentUser.contains(element)).toList());

    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Obx((){
      return TabBarView(
        children: [
          presentTab(),
          absentTab(),
        ],
      );
    });
  }

  presentTab(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: presentUser.length,
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 30, vertical: sizeConfig.height * 15),
      itemBuilder: item1,
    );
  }

  absentTab(){
    return ListView.builder(
      shrinkWrap: true,
      itemCount: absentUser.length,
      padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 30, vertical: sizeConfig.height * 15),
      itemBuilder: item2,
    );
  }

  Widget item1(BuildContext context, int index) {
    UserModel data = presentUser[index];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(sizeConfig.width * 20)),
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        onTap: () async{
          bool reload = await Get.to(GroupMemberDetailsScreen(), arguments: data);
          if(reload !=null){
            if(reload){
              getData();
            }
          }
        },

        leading: CircleAvatar(
          radius: sizeConfig.getSize(30),
          backgroundImage: CachedNetworkImageProvider(
            data.userPhoto
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: data.userName,
                  style: TextStyle(
                      color: Colors.black,
                    fontSize: sizeConfig.getSize(18),
                    fontWeight: FontWeight.normal
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget item2(BuildContext context, int index) {
    UserModel data = absentUser[index];
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(sizeConfig.width * 20)),
      child: ListTile(
        contentPadding: EdgeInsets.all(8),
        onTap: () async{
          bool reload = await Get.to(GroupMemberDetailsScreen(), arguments: data);
          if(reload !=null){
            if(reload){
              getData();
            }
          }},
        leading: CircleAvatar(
          radius: sizeConfig.getSize(30),
          backgroundImage: CachedNetworkImageProvider(
            data.userPhoto
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                  text: data.userName,
                  style: TextStyle(
                      color: Colors.black,
                    fontSize: sizeConfig.getSize(18),
                    fontWeight: FontWeight.normal
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
