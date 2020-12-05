import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/main_app/util/date_helper.dart';

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

  List<DateTime> checkInData;
  DateTime lastCheckIn;

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
    this.address,
    this.facebookID,
    this.instagramID,
    this.lastCheckIn,
    this.phoneNumber
  });

  Map<String, dynamic> toJson(){
    List<Timestamp> timestampList = [];
    if(checkInData.isNotEmpty){
      checkInData.forEach((v) {
          timestampList.add(DateHelper().fromDateTimeToTimestamp(v));
        }
      );
    }
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

      "checkInData": timestampList,
      "lastCheckIn": DateHelper().fromDateTimeToTimestamp(lastCheckIn)??'',

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
    // lastCheckIn = DateHelper().fromTimestampToDateTime(json['lastCheckIn']);
    if(json['checkInLog']!=null){
      checkInData = List<DateTime>();
      json['checkInLog'].forEach((v){
        checkInData.add(DateHelper().fromTimestampToDateTime(v));
      });
    }
  }
}