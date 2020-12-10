import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';

class RepoHome{
  static checkLastCheckIn() async{
    UserDataController userData = Get.find();
    DocumentSnapshot data = await FirebaseFirestore.instance.collection('User').doc(userData.userData.value.userID).get();
    Timestamp lastCheckIn = data.data()['lastCheckIn'];
    if(DateTime.now().day == lastCheckIn.toDate().day){
      return true;
    }else{
      return false;
    }
  }
}