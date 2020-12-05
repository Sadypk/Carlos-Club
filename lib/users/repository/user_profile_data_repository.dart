import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/authentication/models/login_error_model.dart';
import 'package:flutter_app/users/models/group_model.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class UserProfileDataRepository{
  var logger = Logger();

  UserModel userModel = UserModel();
  GetStorage localStorage = GetStorage();

  UserDataController userDataController = Get.find();

  final databaseReference = FirebaseFirestore.instance;
  CollectionReference user = FirebaseFirestore.instance.collection('User');
  CollectionReference group = FirebaseFirestore.instance.collection('Groups');
  CollectionReference loginErrors = FirebaseFirestore.instance.collection('LoginErrors');

  addNewUser(UserModel data) async {
    try{
      await databaseReference.collection("User").doc(data.userID).set(data.toJson());
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


  updateUserData(UserModel data) async {
    try{
      await databaseReference.collection("User").doc(data.userID).update(data.toJson());

      bool session = localStorage.hasData('userValues');
      print(session);
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
           getGroupData(userDataController.userData.value.userGroupID);
         }

        if(rememberMe){
          updateSession();
        }
        return 'user Found';
      }
  }

  getGroupData(groupID) async {
    Query query = group.where('userGroupID',isEqualTo: groupID);
    QuerySnapshot querySnapshot = await query.get();
    userDataController.groupData.value = GroupModel.fromJson(querySnapshot.docChanges[0].doc.data());
  }

  listenToData(email,userLoginType){
    user.where('email',isEqualTo: email).where('userLoginType',isEqualTo: userLoginType).snapshots().listen((value) {
      userDataController.userData.value = UserModel.fromJson(value.docChanges[0].doc.data());
      print('listening to user modeling...');
    });
  }

  updateSession(){
    print('updating cookies...');
    localStorage.write('userValues',userDataController.userData.value);
    print(localStorage.read('userValues'));
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
}