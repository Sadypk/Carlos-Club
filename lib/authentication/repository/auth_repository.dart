import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_app/authentication/models/login_error_model.dart';
import 'package:flutter_app/authentication/view/login_page.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:flutter_app/users/repository/groupMemberData.dart';
import 'package:flutter_app/users/repository/user_profile_data_repository.dart';
import 'package:flutter_app/users/view/screens/admin/adminHomeScreen.dart';
import 'package:flutter_app/users/view/screens/members/memberHomeScreen.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthRepository extends GetxController {

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn();
  FacebookLogin _facebookSignIn = FacebookLogin();

  var fbResult,googleResults;
  var logger = Logger();

  GetStorage localStorage = GetStorage();
  UserDataController userDataController = Get.find();

  updateData(data,image) async {
    try {
      Reference ref = storage.ref().child("user/${userDataController.userData.value.userID}");
      if(image != null){
        UploadTask uploadTask = ref.putFile(image);
        TaskSnapshot res = await uploadTask;
        if (res != null) {
          var photoURL = await res.ref.getDownloadURL();
          var userData = UserModel(
            userID: data.userID,
            userGroupID: data.userGroupID,
            userName: data.userName,
            email: data.email,
            userPhoto: photoURL,
            address: data.address,
            phoneNumber: data.phoneNumber,
            userType: data.userType,
            userLoginType: data.userLoginType,
            checkInData: data.checkInData,
            lastCheckIn: data.lastCheckIn,
            facebookID: data.facebookID,
            instagramID: data.instagramID,
          );
          try {
            await UserProfileDataRepository().updateUserData(userData);
          } on FirebaseAuthException catch (e) {
            //Error on saving data to database
            logger.i(e.message);
            return e.message;
          }
        }
      }else{
        var userData = UserModel(
          userID: data.userID,
          userGroupID: data.userGroupID,
          userName: data.userName,
          email: data.email,
          userPhoto: data.userPhoto,
          address: data.address,
          phoneNumber: data.phoneNumber,
          userType: data.userType,
          userLoginType: data.userLoginType,
          checkInData: data.checkInData,
          lastCheckIn: data.lastCheckIn,
          facebookID: data.facebookID,
          instagramID: data.instagramID,
        );
        try {
          await UserProfileDataRepository().updateUserData(userData);
        } on FirebaseAuthException catch (e) {
          //Error on saving data to database
          logger.i(e.message);
          return e.message;
        }
      }

    } on FirebaseAuthException catch (e) {
      //Error on uploading picture to storage
      logger.i(e.message);
      return e.message;
    }
  }

  createUser(String name, String email, String password, File userPhoto, String userType, String loginType) async {
    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      try {
        Reference ref = storage.ref().child("user/${user.user.uid}");
        UploadTask uploadTask = ref.putFile(userPhoto);
        TaskSnapshot res = await uploadTask;
        if (res != null) {
          var photoURL = await res.ref.getDownloadURL();
          try {
            await addUserToDatabase(
                name, email, photoURL, userType, loginType, user.user.uid);
          } on FirebaseAuthException catch (e) {
            //Error on saving data to database
            logger.i(e.message);
            return e.message;
          }
        }
      } on FirebaseAuthException catch (e) {
        //Error on uploading picture to storage
        logger.i(e.message);
        return e.message;
      }
    } on FirebaseAuthException catch (e) {
      //Error on existing account of same email
      logger.i(e.message);
      return e.message;
    }
  }

  addUserToDatabase(name, email, userPhoto, userType, loginType, userID) async {
    try {
      DateTime staticTime = DateTime(2020, 1, 1, 12, 1, 1, 1, 1);
      Timestamp timestamp = Timestamp.fromDate(staticTime);


      //DateTime dateNow = now.toDate(); //TimeStamp to Date
      //DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch) //TimeStamp to Date
      var data = UserModel(
        userID: userID,
        userGroupID: '',
        userName: name,
        email: email,
        userPhoto: userPhoto,
        address: '',
        phoneNumber: '',
        userType: userType,
        userLoginType: loginType,
        checkInData: [],
        lastCheckIn: timestamp,
        facebookID: '',
        instagramID: '',
      );
      try {
        await UserProfileDataRepository().addNewUser(data);
      } on FirebaseAuthException catch (e) {
        // Error on adding data to firebase
        logger.i(e.message);
        return e.message;
      }
    } on FirebaseAuthException catch (e) {
      //Error on model class
      logger.i(e.message);
      return e.message;
    }
  }

  login(String email, String password,bool rememberMe) async {
    String userLoginType = 'regular';

    try {
      var isSuccess = await _auth.signInWithEmailAndPassword(
          email: email.trim(), password: password);
      print('Successfully logged in $isSuccess');

      if (isSuccess != null) {
        await UserProfileDataRepository().getUserData(isSuccess.user.email, userLoginType,rememberMe);

        userTypeIdentify();
        return null;
      }
    } on FirebaseAuthException catch (eLogin) {
      // Error logging in
      var data = ErrorModel(
        message: '${eLogin.message} [Email: $email]',
        timestamp: Timestamp.now(),
      );
      try {
        await UserProfileDataRepository().loginFailed(data);
        logger.i(eLogin.message);
        return eLogin.message;
      } on FirebaseAuthException catch (eErrorData) {
        // Error on adding error data
        logger.i(eErrorData.message);
        return eErrorData.message;
      }
    }
  }

  signOut() async {
    try {
      if (_googleSignIn.currentUser != null) {
        _googleSignIn.signOut();
      }else if(_facebookSignIn.isLoggedIn != null){
        _facebookSignIn.logOut();
      } else {
        _auth.signOut();
      }
      localStorage.remove('userValues');
      Get.offAll(LoginPage());
    } catch (e) {
      Get.snackbar(
        "Error signing out",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future handleGoogleSignIn() async {
    bool rememberUser = true;
    String userType = 'member'; // if creating new account
    String userLoginType = 'google';

    try{
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      if(googleSignInAccount != null){
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        var existingAccount = await UserProfileDataRepository().checkExistingFacebookEmail(googleSignInAccount.email, 'facebook');
        if (existingAccount == null) {
          /// creating new user
          //login result
          UserCredential result = await _auth.signInWithCredential(credential);
          if (result != null) {
            var dbHasException = await UserProfileDataRepository().getUserData(result.user.email, userLoginType,rememberUser);
            //check if there's same email in firebase
            if (dbHasException == null) {
              //if no email found in Firebase
              var hasException = await addUserToDatabase(
                  result.user.displayName,
                  result.user.email,
                  result.user.photoURL,
                  userType,
                  userLoginType,
                  _auth.currentUser.uid);
              if (hasException != null) {
                logger.i('error');
              } else {
                /// logging in to existing user
                await UserProfileDataRepository().getUserData(result.user.email, userLoginType,rememberUser);
                //get user data after adding to Firebase
                userTypeIdentify();
                return 'true';
                logger.i('success');
              }
            } else {
              userTypeIdentify();
            }
          }
        }
        else{
          return 'An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.';
        }
      }
    }on FirebaseAuthException catch (eErrorData) {
      // Error on adding error data
      logger.i(eErrorData.message);
      googleResults = eErrorData.message;
      return googleResults;
    }
    return googleResults;
  }

  Future loginFacebook() async {
    bool rememberUser = true;
    print('Starting Facebook Login');
/*
    final res = await _facebookSignIn.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);*/
    _facebookSignIn.loginBehavior = FacebookLoginBehavior.webViewOnly;

    final res = await _facebookSignIn.logIn(['email']);

    if (res.status == FacebookLoginStatus.loggedIn) {
      // if creating new account
      String userType = 'member';
      String userLoginType = 'facebook';
      try {
        //Get Token
        final FacebookAccessToken fbToken = res.accessToken;
        //Convert to Auth Credential
        final AuthCredential credential = FacebookAuthProvider.credential(fbToken.token);
        //User Credential to Sign in with Firebase
        UserCredential result = await _auth.signInWithCredential(credential); //login result
        if (result != null) {
          //check if there's same email in firebase
          var dbHasException = await UserProfileDataRepository().getUserData(result.user.email, userLoginType,rememberUser);
          //if no email found in Firebase
          if (dbHasException == null) {
            var hasException = await addUserToDatabase(
                result.user.displayName,
                result.user.email,
                result.user.photoURL,
                userType,
                userLoginType,
                _auth.currentUser.uid);
            if (hasException != null) {
              logger.i('error');
            } else {
              //get user data after adding to Firebase
              await UserProfileDataRepository().getUserData(result.user.email, userLoginType,rememberUser);
              //after user is added
              userTypeIdentify();
              logger.i('success');
            }
          }else {
            //if user found
            userTypeIdentify();
          }
        }
      } on FirebaseAuthException catch (eErrorData) {
        // Error on adding error data
        logger.i(eErrorData.message);
        fbResult = eErrorData.message;
        return fbResult;
      }
      return fbResult;
    }
    else if (res.status == FacebookLoginStatus.cancelledByUser) {
      return 'The user canceled the login';
    } else {
      return 'There was an error logging in';
    }
  }


  userTypeIdentify(){
    // Future.delayed(Duration(milliseconds: 1000)).then((value){
      userTypeIdentifier();
    // });
  }

  userTypeIdentifier() async{
    await getData(userDataController.userData.value.email,userDataController.userData.value.userGroupID,userDataController.userData.value.userType,userDataController.userData.value.userLoginType);
    if(userDataController.userData.value.userType == 'member'){
      Get.offAll(MemberHomeScreen());
    }else{
      Get.offAll(AdminHomeScreen());
    }
  }

  sessionTypeIdentifier() async {
    getData(userDataController.sessionData.value.email,userDataController.sessionData.value.userGroupID,userDataController.sessionData.value.userType,userDataController.sessionData.value.userLoginType);
    if(userDataController.sessionData.value.userType == 'member'){
      Get.offAll(MemberHomeScreen());
    }else{
      Get.offAll(AdminHomeScreen());
    }
  }

  getData(email,groupID,userType,userLoginType) async {
    await UserProfileDataRepository().listenToUserData(email,userLoginType);
    if(groupID != ''){
      await RepoGroupMembers().getGroupData(groupID);
      if(userType == 'admin'){
        await RepoGroupMembers().listenToCheckInData();
      }
    }
  }
}
