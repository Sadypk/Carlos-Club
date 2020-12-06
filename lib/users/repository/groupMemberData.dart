import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/users/models/group_model.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';

class RepoGroupMembers {
  UserDataController userDataController = Get.find();
  final CollectionReference group =
      FirebaseFirestore.instance.collection('Groups');
  final CollectionReference user =
      FirebaseFirestore.instance.collection('User');

  getGroupMemberData() async {
    userDataController.groupMemberData.clear();
    QuerySnapshot documents = await user
        .where('userGroupID',
            isEqualTo: userDataController.userData.value.userGroupID).get();
    documents.docs.forEach((element) {
      userDataController.groupMemberData.add(UserModel.fromJson(element.data()));
    });
  }

  getMembersInformation() async {
    QuerySnapshot querySnapshot =
        await user.where('userGroupID', isEqualTo: "").get();

    querySnapshot.docs.forEach((element) {
      userDataController.ungroupMemberData.add(UserModel.fromJson(element.data()));
    });
  }

  getGroupData(groupID) async {
    DocumentSnapshot documentSnapshot = await group.doc(groupID).get();
    userDataController.groupData.value =
        GroupModel.fromJson(documentSnapshot.data());
  }

  listenToGroupData(groupID) {
    group.doc(groupID).snapshots().listen((value) {
      userDataController.groupData.value = GroupModel.fromJson(value.data());
      print('listening to group model...');
    });
  }
}
