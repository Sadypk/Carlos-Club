import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/authentication/models/login_error_model.dart';
import 'package:flutter_app/users/models/group_model.dart';
import 'package:flutter_app/users/models/userSessionModel.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import 'groupMemberData.dart';

class UserProfileDataRepository{
  var logger = Logger();

  UserModel userModel = UserModel();
  GetStorage localStorage = GetStorage();

  RepoGroupMembers repoGroupMembers = RepoGroupMembers();
  UserDataController userDataController = Get.find();

  CollectionReference user = FirebaseFirestore.instance.collection('User');
  CollectionReference loginErrors = FirebaseFirestore.instance.collection('LoginErrors');

  userCheckIn(userID,timestamp) async {
    try{
      user.doc(userID).update({'checkInData' : FieldValue.arrayUnion([timestamp])});
      user.snapshots().listen((value) {
        print('listening to manual...');
        userDataController.groupMemberData.clear();
        value.docs.forEach((element) {
          userDataController.groupMemberData.add(UserModel.fromJson(element.data()));
        });

      });
    }catch(e){
      logger.i(e);
      return e;
    }
  }

  addNewUser(UserModel data) async {
    try{
      await user.doc(data.userID).set(data.toJson());
    }catch(e){
      logger.i(e);
      return e;
    }
  }

  loginFailed(ErrorModel data) async {
    try{
      await loginErrors.add(data.toJson()).then((value) => logger.i(value)).catchError((e){logger.e(e);});
    }catch(e){
      logger.i(e);
      return e;
    }
  }

  checkExistingFacebookEmail(email,userLoginType) async {
    Query query = user.where('email',isEqualTo: email).where('userLoginType',isEqualTo: userLoginType);
    QuerySnapshot querySnapshot = await query.get();
    if(querySnapshot.docs.isEmpty){
      return null;
    }else{
      return 'facebook account available';
    }
  }

  updateUserData(UserModel data) async {
    try{
      await user.doc(data.userID).update(data.toJson());

      bool session = localStorage.hasData('userValues');

      if(session){
        updateSession();
      }

    }catch(e){
      logger.i(e);
      return e;
    }

  }

  getUserData(email,userLoginType,rememberMe) async{
    Query query = user.where('email',isEqualTo: email).where('userLoginType',isEqualTo: userLoginType);
    QuerySnapshot querySnapshot = await query.get();
      if(querySnapshot.docs.isEmpty){
        return null;
      }else{

        QuerySnapshot querySnapshot2 = await user.where('email',isEqualTo: email).where('userLoginType',isEqualTo: userLoginType).get();
        userDataController.userData.value = UserModel.fromJson(querySnapshot2.docChanges[0].doc.data());

        if(userDataController.userData.value.userGroupID != null){
          repoGroupMembers.getGroupData(userDataController.userData.value.userGroupID);
         }

        if(rememberMe){
          updateSessionModel();
          updateSession();
        }
        return 'user Found';
      }
  }

  listenToUserData(email,userLoginType){
    user.where('email',isEqualTo: email).where('userLoginType',isEqualTo: userLoginType).snapshots().listen((value) {
      userDataController.userData.value = UserModel.fromJson(value.docChanges[0].doc.data());
      print('listening to user model...');
    });
  }

  updateSessionModel(){
    var sessionData =  UserSessionModel(
        email: userDataController.userData.value.email,
        userLoginType:  userDataController.userData.value.userLoginType,
        userType:  userDataController.userData.value.userType,
        userGroupID: userDataController.userData.value.userGroupID
    );
    userDataController.sessionData.value = sessionData;
  }

  updateSession(){
    print('updating cookies...');
    localStorage.write('userValues',userDataController.sessionData.value);
    print(localStorage.read('userValues'));
  }

}