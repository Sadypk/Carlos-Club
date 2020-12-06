import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';

class RepoGroupMembers{
static UserDataController userDataController = Get.find();
  static final CollectionReference user = FirebaseFirestore.instance.collection('User');

  static  getGroupMemberData() async{
    QuerySnapshot documents = await user.where('userGroupID',isEqualTo: userDataController.userData.value.userGroupID).get();
    documents.docs.forEach((element) {
      UserDataController.groupMemberData.add(UserModel.fromJson(element.data()));
    });
}


  static getMembersInformation() async {
  QuerySnapshot querySnapshot = await user.where('userGroupID',isEqualTo: "").get();

  querySnapshot.docs.forEach((element) {
    UserDataController.ungroupMemberData.add(UserModel.fromJson(element.data()));
  });
}

}