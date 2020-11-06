import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/general/view/calenderView.dart';
import 'package:flutter_app/general/view/qrScanner.dart';
import 'package:flutter_app/member/models/demos.dart';
import 'package:flutter_app/member/view/memberCheckInHistory.dart';
import 'package:flutter_app/member/view/memberProfileScreen.dart';
import 'package:flutter_app/member/view_model/memberHomeScreen.dart';
import 'package:flutter_app/utils/appConst.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';

class MemberHomeScreen extends StatefulWidget {
  @override
  _MemberHomeScreenState createState() => _MemberHomeScreenState();
}

class _MemberHomeScreenState extends State<MemberHomeScreen> {

  final GetSizeConfig sizeConfig = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MemberHomeScreenViewModel.appBarText,
          style: TextStyle(
            fontSize: sizeConfig.getSize(22),
            fontWeight: FontWeight.bold
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () => Get.to(MemberProfileScreen()),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: sizeConfig.getSize(4),horizontal: sizeConfig.getSize(10)),
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  MemberHomeScreenViewModel.profilePic
                ),
              ),
            ),
          )
        ],
        bottom: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Container(
            margin: EdgeInsets.only(
              top: sizeConfig.height * 20
            ),
            height: sizeConfig.height * 80,
            child: Marquee(
              text: 'Some sample text that takes some space.',
              style: TextStyle(
                color: Colors.black,
                fontSize: sizeConfig.getSize(22)
              ),
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              blankSpace: 20.0,
              velocity: 50.0,
              pauseAfterRound: Duration(seconds: 1),
              startPadding: 10.0,
              accelerationDuration: Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
        )
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: sizeConfig.width * 80
        ),
        child: Column(
          children: [
            qrScanners(),
            Divider(
              color: Colors.grey,
              thickness: 1.5,
              height: sizeConfig.height * 30,
            ),
            attendenceList(),
          ],
        ),
      ),
    );
  }

  Widget qrScanners() {
    return Padding(
      padding: EdgeInsets.only(bottom: sizeConfig.height * 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlatButton(
            onPressed: () async{
              String result = await Get.dialog(QRScanner());
              if(result == 'success'){
                checkInSuccessFull();
              }else{
                checkInFailed();
              }
            },
            color: AppConst.green,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 20)),
            minWidth: double.infinity,
            height: sizeConfig.height * 80,
            child: Text(
              MemberHomeScreenViewModel.btnScanQr,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: sizeConfig.getSize(28),
                color: Colors.white
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 20),
            child: Text(
              'Or',
              style: TextStyle(
                fontSize: sizeConfig.getSize(20),
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          FlatButton(
            onPressed: (){
              manualCheckIn();
            },
            color: AppConst.deepOrange,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 20)),
            minWidth: sizeConfig.width * 700,
            height: sizeConfig.height * 80,
            child: Text(
              MemberHomeScreenViewModel.btnManualCheckIn,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: sizeConfig.getSize(28),
                color: Colors.white
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget attendenceList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          MemberHomeScreenViewModel.attendenceHeader,
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
                itemCount: demoCheckInData.length > 5 ? 5 :  demoCheckInData.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: sizeConfig.height * 10),
                itemBuilder: data,
              ),
              demoCheckInData.length > 5 ?
                  InkWell(
                    onTap: () => Get.to(MemberCheckInHistory()),
                    child: Text(
                      MemberHomeScreenViewModel.btnSeeAll,
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
                        MemberHomeScreenViewModel.btnViewCalender,
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
    DemoCheckInModel data = demoCheckInData[index];
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
            data.date,
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
              width: sizeConfig.width * 300,
              height: 2,
            )
          ),
          Text(
            data.time,
            style: TextStyle(
              fontSize: sizeConfig.getSize(18),
              color: Colors.green
            )
          )
        ],
      ),
    );
  }
  
  void manualCheckIn() {
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
                      MemberHomeScreenViewModel.manualCheckInChooseDate,
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
                        width: sizeConfig.width * 400,
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
                      MemberHomeScreenViewModel.manualCheckInChooseTime,
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
                        width: sizeConfig.width * 400,
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
      btnOkOnPress: () {},
      btnCancelOnPress: (){}
    )..show();
  }

  void showCalenderZView() {
    Get.dialog(Dialog(child: CalenderView(),));
  }
  
  void checkInSuccessFull() {
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