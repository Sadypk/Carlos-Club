class UserModel{
  String email;
  String userType;
  String userName;
  List<DateTime> checkInLog;

  UserModel({
    this.userName,
    this.userType,
    this.email,
    this.checkInLog
  });

  Map<String, dynamic> toJson(){
    var data = {
      "email": email??'',
      "userType": userType??'',
      "userName": userName??'',
    };
    return data;
  }

  UserModel.fromJson(Map<String, dynamic> json){
    userName = json['userName'];
    userType = json['userType'];
    email = json['email'];
    if(json['checkInLog']!=null){
      checkInLog = new List<DateTime>();
      json['checkInLog'].forEach((v){
        checkInLog.add(v);
      });
    }
  }
}