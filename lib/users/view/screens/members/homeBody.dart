import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/main_app/widgets/logout_dialog.dart';
import 'package:flutter_app/users/repository/user_profile_data_repository.dart';
import 'package:flutter_app/users/view/widgets/calenderView.dart';
import 'package:flutter_app/users/view/widgets/qrScanner.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'memberCheckInHistory.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final GetSizeConfig sizeConfig = Get.find();
  UserDataController userDataController = Get.find();
  UserProfileDataRepository userProfileDataRepository = UserProfileDataRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(vertical: sizeConfig.getSize(4),horizontal: sizeConfig.getSize(10)),
          child: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
                StringResources.memberHomeScreenProfilePic
            ),
          ),
        ),
        title: Text('Welcome: ${userDataController.userData.value.userName}'),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PopupMenuButton(
              child: Icon(Icons.exit_to_app),
              onSelected: (bool value){
                if(value){
                  Get.dialog(LogoutDialog());
                }else{
                }
              },
              itemBuilder: (_){
                return [
                  PopupMenuItem(
                    value: true,
                    child: Text(
                        'Logout'
                    ),
                  )
                ];
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: sizeConfig.width * 80
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: sizeConfig.height * 15,),
              qrScanners(),
              Divider(
                color: Colors.grey,
                thickness: 1.5,
                height: sizeConfig.height * 30,
              ),
              attendanceList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget qrScanners() {
    return Padding(
      padding: EdgeInsets.only(bottom: sizeConfig.height * 10),
      child: FlatButton(
        onPressed: () async{
          String result = await Get.dialog(QRScanner());
          if(result == 'success'){
            Timestamp timestamp = Timestamp.now();
            userProfileDataRepository.userCheckIn(userDataController.userData.value.userID,timestamp);
            checkInSuccessful();
          }else{
            checkInFailed();
          }
        },
        color: AppConst.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 20)),
        minWidth: double.infinity,
        height: sizeConfig.height * 80,
        child: Text(
          StringResources.memberHomeScreenBtnScanQr,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sizeConfig.getSize(28),
              color: Colors.white
          ),
        ),
      ),
    );
  }

  Widget attendanceList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          StringResources.memberHomeScreenAttendenceHeader,
          style: TextStyle(
              color: AppConst.chocolate,
              fontWeight: FontWeight.bold,
              fontSize: sizeConfig.getSize(20)
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: sizeConfig.height  *10),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1.5,
                  color: Colors.grey
              )
          ),
          child: Column(
            children: [
              ListView.builder(
                itemCount: userDataController.userData.value.checkInData.length > 10 ? 10 :  userDataController.userData.value.checkInData.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: sizeConfig.height * 10),
                itemBuilder: data,
              ),
              userDataController.userData.value.checkInData.length > 10 ?
              InkWell(
                onTap: () => Get.to(MemberCheckInHistory()),
                child: Text(
                  StringResources.memberHomeScreenBtnSeeAll,
                  style: TextStyle(
                      color: AppConst.magenta,
                      fontSize: sizeConfig.getSize(18),
                      decoration: TextDecoration.underline
                  ),
                ),
              ) :
              SizedBox(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: sizeConfig.getSize(7)),
                child: OutlineButton(
                  onPressed: (){
                    showCalenderZView();
                  },
                  borderSide: BorderSide(
                      color: Colors.grey,
                      width: 2
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 20)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                          Icons.date_range
                      ),
                      SizedBox(width: sizeConfig.width * 10,),
                      Text(
                        StringResources.memberHomeScreenBtnViewCalender,
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }



  Widget data(BuildContext context, int index) {
    //DemoCheckInModel data = demoCheckInData[index];
    Timestamp timestamp = userDataController.userData.value.checkInData[index];
    return Padding(
      padding:  EdgeInsets.only(
        bottom: sizeConfig.height * 15,
        left: sizeConfig.width * 20,
        right: sizeConfig.width * 20,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('dd MMM yyyy').format(timestamp.toDate()),
            style: TextStyle(
                fontSize: sizeConfig.getSize(18)
            ),
          ),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizeConfig.width * 20
              ),
              child: Container(
                color: Colors.grey,
                width: sizeConfig.width * 200,
                height: 2,
              )
          ),
          Text(
              DateFormat().add_jms().format(timestamp.toDate()),
              style: TextStyle(
                  fontSize: sizeConfig.getSize(18),
                  color: Colors.green
              )
          )
        ],
      ),
    );
  }

  void showCalenderZView() {
    Get.dialog(Dialog(child: CalenderView(checkInData: userDataController.userData.value.checkInData,)));
  }

  void checkInSuccessful() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.TOPSLIDE,
      title: 'Success',
      desc: 'Check In at ${DateFormat('dd MMM').add_jms().format(DateTime.now())}',
      btnOkOnPress: () {},
    )..show();
  }

  void checkInFailed() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Error',
      desc: 'Check In failed',
      btnCancelOnPress: () {},
    )..show();
  }

  selectDate() async{
    DateTime dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );

    if(dateTime==null){
      return null;
    }else{
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }

  }

  selectTime() async{
    TimeOfDay time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 00, minute: 00)
    );
    if(time == null){
      return null;
    }else{
      return time.format(context);
    }
  }
}
