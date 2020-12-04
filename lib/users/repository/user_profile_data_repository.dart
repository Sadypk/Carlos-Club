import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:logger/logger.dart';
import 'package:get/get.dart';

class UserProfileDataRepository{
  CollectionReference _collectionReference = FirebaseFirestore.instance.collection('User');
  var logger = Logger();
  UserProfileViewModel userProfileViewModel = Get.put(UserProfileViewModel());


  checkIn(){

  }

  addNewUser(UserModel data){
    _collectionReference.add(data.toJson()).then((value) => logger.i(value)).catchError((e){logger.e(e);});
  }

  updateUserData(Map<String, dynamic> data) async{
    QuerySnapshot querySnapshot = await _collectionReference.where('email',isEqualTo: userProfileViewModel.userModel.email).get();
    logger.i(querySnapshot.docs[0].data());
    try{
      querySnapshot.docs[0].reference.update(data);
    }catch(e){
      logger.e(e);
    }
  }


  getUserData(){
    print('trying to get');
    try{
      _collectionReference.where('email',isEqualTo: 'zxc@gmail.com').snapshots().listen((value) {
        logger.i(value.docChanges[0].doc.data());

        var data = UserModel.fromJson(value.docChanges[0].doc.data());
        userProfileViewModel.userModel = data;

      });
    }catch(e){
      logger.e(e);
    };
  }

}