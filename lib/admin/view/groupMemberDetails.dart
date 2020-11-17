import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/general/view/calenderView.dart';
import 'package:flutter_app/general/view/qrScanner.dart';
import 'package:flutter_app/member/models/demos.dart';
import 'package:flutter_app/member/view/memberCheckInHistory.dart';
import 'package:flutter_app/member/view_model/memberHomeScreen.dart';
import 'package:flutter_app/utils/appConst.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:flutter_app/utils/widgets/textField.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupMemberDetailsScreen extends StatefulWidget {
  @override
  _GroupMemberDetailsScreenState createState() => _GroupMemberDetailsScreenState();
}

class _GroupMemberDetailsScreenState extends State<GroupMemberDetailsScreen> {
  final GetSizeConfig sizeConfig = Get.find();
  DemoUsersModel data = Get.arguments;

  TextEditingController emailController = TextEditingController();
  FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode()..addListener(() {setState(() {});});
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
                  data.image
                ),
              ),
            ),
            Text(data.fName + ' ' + data.lName),
          ],
        ),
        elevation: 0,
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
              attendenceList(),
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
          await manualCheckIn();
        },
        color: AppConst.deepOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 20)),
        minWidth: double.infinity,
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
                RoundedTextField(
                  labelText: 'User email',
                  icon: Icons.email_outlined,
                  controller: emailController,
                  focusNode: focusNode
                ),
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
          checkInSuccessFull();
        },
        btnCancelOnPress: (){
          checkInFailed();
        }
    )..show();
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
                itemCount: demoCheckInData.length > 10 ? 10 :  demoCheckInData.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: sizeConfig.height * 10),
                itemBuilder: listItem,
              ),
              demoCheckInData.length > 10 ?
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

  Widget listItem(BuildContext context, int index) {
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
