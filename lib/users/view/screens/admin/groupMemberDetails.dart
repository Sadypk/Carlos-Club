import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/users/models/user_model.dart';
import 'package:flutter_app/users/repository/user_profile_data_repository.dart';
import 'package:flutter_app/users/view/widgets/calenderView.dart';
import 'package:flutter_app/users/view/screens/members/memberCheckInHistory.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupMemberDetailsScreen extends StatefulWidget {
  @override
  _GroupMemberDetailsScreenState createState() => _GroupMemberDetailsScreenState();
}

class _GroupMemberDetailsScreenState extends State<GroupMemberDetailsScreen> {
  final GetSizeConfig sizeConfig = Get.find();
  UserModel data;

  UserDataController userDataController = Get.find();
  TextEditingController emailController = TextEditingController();
  UserProfileDataRepository userProfileDataRepository = UserProfileDataRepository();
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode()..addListener(() {setState(() {});});
    data = Get.arguments;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: sizeConfig.getSize(4),horizontal: sizeConfig.getSize(10)),
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  data.userPhoto
                ),
              ),
            ),
            Text(data.userName),
          ],
        ),
        elevation: 0,
      ),
      body: Obx((){
        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: sizeConfig.width * 80
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: sizeConfig.height * 15,),
                manualCheckInButton(),
                Divider(
                  color: Colors.grey,
                  thickness: 1.5,
                  height: sizeConfig.height * 30,
                ),
                attendanceList(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget manualCheckInButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: sizeConfig.height * 10),
      child: FlatButton(
        onPressed: () async{
          await manualCheckIn();
        },
        color: AppConst.deepOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 20)),
        minWidth: double.infinity,
        height: sizeConfig.height * 80,
        child: Text(
          StringResources.groupScreenBtnManualCheckIn,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sizeConfig.getSize(28),
              color: Colors.white
          ),
        ),
      ),
    );
  }

  manualCheckIn() {
    String selectedDate;
    String selectedTime;
    AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.TOPSLIDE,
        body: StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: sizeConfig.height * 80,
                  padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 30),
                  child: Row(
                    children: [
                      Text(
                        StringResources.memberHomeScreenManualCheckInChooseDate,
                        style: TextStyle(
                          fontSize: sizeConfig.getSize(18),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async{
                          selectedDate = await selectDate();
                          if(selectedDate != null){
                            setState(() {});
                          }
                        },
                        child: Container(
                          height: sizeConfig.height * 60,
                          width: sizeConfig.width * 350,
                          color: selectedDate == null ? Colors.grey[300] : Colors.transparent,
                          child: Center(
                            child: Text(
                              selectedDate ?? 'dd / MM',
                              style: TextStyle(
                                fontSize: sizeConfig.getSize(18),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: sizeConfig.height * 80,
                  padding: EdgeInsets.symmetric(horizontal: sizeConfig.width * 30),
                  child: Row(
                    children: [
                      Text(
                        StringResources.memberHomeScreenManualCheckInChooseTime,
                        style: TextStyle(
                          fontSize: sizeConfig.getSize(18),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async{
                          selectedTime = await selectTime();
                          if(selectedTime != null){
                            setState((){});
                          }
                        },
                        child: Container(
                          height: sizeConfig.height * 60,
                          width: sizeConfig.width * 350,
                          color: selectedTime == null ? Colors.grey[300] : Colors.transparent,
                          child: Center(
                            child: Text(
                              selectedTime ?? 'hh : mm',
                              style: TextStyle(
                                fontSize: sizeConfig.getSize(18),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        btnOkOnPress: (){
         if(selectedTime != null && selectedDate != null){
           String mAlertDateTime = selectedDate + " " + selectedTime;
           DateFormat  dft = DateFormat("dd/MM/yyyy HH:mm a");
           DateTime finalDate = dft.parse(mAlertDateTime);
           Timestamp timestamp = Timestamp.fromDate(finalDate);

           userProfileDataRepository.userCheckIn(data.userID,timestamp);
           checkInSuccessful();
         }
        },
        btnCancelOnPress: (){
          checkInFailed();
        }
    )..show();
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
              data.checkInData.isEmpty?Container(child: Text('No Check-In History'),):ListView.builder(
                itemCount: data.checkInData.length > 10 ? 10 :  data.checkInData.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: sizeConfig.height * 10),
                itemBuilder: listItem,
              ),
              data.checkInData.isEmpty?SizedBox(): data.checkInData.length > 10 ?InkWell(
                onTap: () => Get.to(MemberCheckInHistory()),
                child: Text(
                  StringResources.memberHomeScreenBtnSeeAll,
                  style: TextStyle(
                      color: AppConst.magenta,
                      fontSize: sizeConfig.getSize(18),
                      decoration: TextDecoration.underline
                  ),
                ),
              ):Container(),
              data.checkInData.isEmpty?Container():Padding(
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


  Widget listItem(BuildContext context, int index) {
    //DemoCheckInModel data = demoCheckInData[index];
    Timestamp timestamp = data.checkInData[index];
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
    Get.dialog(Dialog(child: CalenderView(checkInData: data.checkInData,)));
  }

  void checkInSuccessful() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.TOPSLIDE,
      title: 'Success',
      desc: 'Check In at ${DateFormat('dd MMM').add_jms().format(DateTime.now())}',
      btnOkOnPress: () {
        Get.back(result: true);
      },
    )..show();
  }

  void checkInFailed() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Error',
      desc: 'Check In failed',
      btnCancelOnPress: () {

      },
    )..show();
  }

  selectDate() async{

    print(data.checkInData);

    DateTime date = await Get.dialog(Dialog(child: CalenderView(checkInData: data.checkInData),),arguments: true);
    print(date);

    if(date==null){
      return null;
    }else{
      return DateFormat('dd/MM/yyyy').format(date);
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
