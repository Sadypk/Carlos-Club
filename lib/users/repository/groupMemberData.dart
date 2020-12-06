import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/users/models/member_model.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';

class RepoGroupMembers{
static UserDataController userDataController = Get.find();
  static final CollectionReference ref = FirebaseFirestore.instance.collection('User');

  static  getGroupMemberData() async{
    QuerySnapshot documents = await ref.where('userGroupID',isEqualTo: userDataController.userData.value.userGroupID).get();
    documents.docs.forEach((element) {
      UserDataController.groupMemberData.add(MemberModel.fromJson(element.data()));
    });
}
}