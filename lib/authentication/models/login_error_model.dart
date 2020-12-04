import 'package:cloud_firestore/cloud_firestore.dart';

class ErrorModel{
  String message;
  Timestamp timestamp;

  ErrorModel({
    this.message,
    this.timestamp,
  });

  Map<String, dynamic> toJson(){
    var data = {
      "message" : message??'',
      "timeStamp": timestamp??'',
    };
    return data;
  }

}