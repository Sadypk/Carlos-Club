import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String userID;
  String userGroupID;

  String userName;
  String email;
  String userPhoto;
  String address;
  String phoneNumber;

  String userType;
  String userLoginType;

  List<Timestamp> checkInData;
  Timestamp lastCheckIn;

  String facebookID;
  String instagramID;


  UserModel({
    this.userID,
    this.userName,
    this.email,
    this.userPhoto,
    this.userType,
    this.userLoginType,
    this.userGroupID,
    this.checkInData,
    this.address,this.facebookID,this.instagramID,this.lastCheckIn,this.phoneNumber
  });

  Map<String, dynamic> toJson(){
    var data = {
      "userID" : userID??'',
      "userGroupID": userGroupID??'',

      "userName": userName??'',
      "email": email??'',
      "userPhoto": userPhoto??'',
      "address": address??'',
      "phoneNumber": phoneNumber??'',

      "userType": userType??'',
      "userLoginType": userLoginType??'',

      "checkInData": checkInData??[],
      "lastCheckIn": lastCheckIn??'',

      "facebookID": facebookID??'',
      "instagramID": instagramID??'',

    };
    return data;
  }

  UserModel.fromJson(Map<String, dynamic> json){
    userID = json['userID'];
    userName = json['userName'];
    email = json['email'];
    userPhoto = json['userPhoto'];
    userType = json['userType'];
    userLoginType = json['userLoginType'];
    userGroupID = json['userGroupID'];
    if(json['checkInLog']!=null){
      checkInData = List<Timestamp>();
      json['checkInLog'].forEach((v){
        checkInData.add(v);
      });
    }
  }
}