import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/users/models/checkIn_model.dart';
import 'package:flutter_app/users/models/group_model.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class RepoGroupMembers {
  var logger = Logger();

  UserDataController userDataController = Get.find();
  final CollectionReference group =
      FirebaseFirestore.instance.collection('Groups');
  final CollectionReference user =
      FirebaseFirestore.instance.collection('User');

  getGroupMemberData() async {
    userDataController.groupMemberData.clear();
    QuerySnapshot querySnapshot = await user.where(
        'userGroupID',
        isEqualTo: userDataController.userData.value.userGroupID
    ).get();
    querySnapshot.docs.forEach((element) {
      userDataController.groupMemberData.add(UserModel.fromJson(element.data()));
    });
  }

  getUngroupedMembers() async {
    userDataController.ungroupMemberData.clear();
    QuerySnapshot querySnapshot = await user.where('userGroupID', isEqualTo: "").get();

    querySnapshot.docs.forEach((element) {
      userDataController.ungroupMemberData.add(UserModel.fromJson(element.data()));
    });
  }

  getGroupData(groupID) async {
    DocumentSnapshot documentSnapshot = await group.doc(groupID).get();
    userDataController.groupData.value =
        GroupModel.fromJson(documentSnapshot.data());
  }


  addToGroup(memberID,groupID) async{
    try{
      await group.doc(groupID).update({'members' : FieldValue.arrayUnion([memberID])});
      await user.doc(memberID).update({'userGroupID' : groupID});
      return null;
    }catch(e){
      logger.i(e);
      return e.toString();
    }
  }

  getUserByEmail(userEmail,groupID) async {
    try{
      QuerySnapshot querySnapshot = await user.where('email', isEqualTo: userEmail).get();
      if(!querySnapshot.isNull){
        var memberID = querySnapshot.docs[0].data();
        await addToGroup(memberID['userID'],groupID);
      }
      return null;
    }catch(e){
      logger.i(e);
      return e.toString();
    }

  }

  listenToGroupData(groupID) {
    print('listenToGroupData');
    group.doc(groupID).snapshots().listen((value) {
      userDataController.groupData.value = GroupModel.fromJson(value.data());
      print('listening to group model...');
    });
  }


  listenToCheckInData(){
    print('listenToCheckInData');
    for(var data in userDataController.groupMemberData){
      print('here on function');
      user.where('userGroupID',isEqualTo: data.userGroupID).snapshots().listen((value) {
        userDataController.checkInData.value = CheckInModel.fromJson(value.docChanges[0].doc.data()['lastCheckIn']);
        print('listening to checkIn model...');
      });
    }
  }
}
