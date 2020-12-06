import 'package:flutter_app/users/models/group_model.dart';
import 'package:flutter_app/users/models/member_model.dart';
import 'package:flutter_app/users/models/userSessionModel.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:get/get.dart';

class UserDataController extends GetxController{
  var userData = UserModel().obs;
  var memberData = MemberModel().obs;
  var groupData = GroupModel().obs;
  var sessionData = UserSessionModel().obs;
  static List<MemberModel> groupMemberData =[];
}
