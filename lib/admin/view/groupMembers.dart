import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/admin/models/demos.dart';
import 'package:flutter_app/admin/view/groupCheckInHistory.dart';
import 'package:flutter_app/admin/view_model/groupsMemers.dart';
import 'package:flutter_app/member/models/demos.dart';
import 'package:flutter_app/member/view_model/memberHomeScreen.dart';
import 'package:flutter_app/utils/appConst.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:flutter_app/utils/widgets/textField.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupMembers extends StatefulWidget {
  @override
  _GroupMembersState createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> with SingleTickerProviderStateMixin{
  final GetSizeConfig sizeConfig = Get.find();

  TextEditingController emailController = TextEditingController();
  FocusNode focusNode = FocusNode();
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    tabController.addListener(() {setState(() {});});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Group name',
          style: TextStyle(
              fontSize: sizeConfig.getSize(22),
              fontWeight: FontWeight.bold
          ),
        ),
        actions: [
          tabController.index == 1 ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlatButton(
              onPressed: (){
                //TODO add memer
              },
              color: Colors.grey[700],
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  SizedBox(width: sizeConfig.width * 10,),
                  Text(
                    'Add member',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )
                ],
              ),
            ),
          ) : SizedBox()
        ],
        bottom: TabBar(
          controller: tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: sizeConfig.getSize(18)
          ),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: sizeConfig.getSize(18)
          ),
          indicatorColor: Colors.red,
          indicatorWeight: 6,
          tabs: [
            Tab(text: GroupPageRepo.tab1),
            Tab(text: GroupPageRepo.tab2),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          groupInfoTab(),
          membersTab(),
        ],
      ),
    );
  }

  Widget groupInfoTab() => Padding(
    padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 15, horizontal: sizeConfig.width * 30),
    child: SingleChildScrollView(
      physics: ClampingScrollPhysics(),
      child: Column(
        children: [
          FlatButton(
            onPressed: manualCheckIn,
            height: sizeConfig.height * 70,
            minWidth: sizeConfig.width * 500,
            color: AppConst.deepOrange,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(sizeConfig.width * 20)),
            child: Text(
              GroupPageRepo.btnManualCheckIn,
              style: TextStyle(
                fontSize: sizeConfig.getSize(30),
                color: Colors.white
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1.5,
            height: sizeConfig.height * 40,
          ),
          attendenceList()
        ],
      ),
    ),
  );

  Widget attendenceList() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            GroupPageRepo.header,
            style: TextStyle(
                color: AppConst.chocolate,
                fontWeight: FontWeight.bold,
                fontSize: sizeConfig.getSize(20)
            ),
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
                itemCount: demoGroupCheckInData.length > 10 ? 10 :  demoGroupCheckInData.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: sizeConfig.height * 10),
                itemBuilder: data,
              ),
              demoCheckInData.length > 10 ?
              InkWell(
                onTap: () => Get.to(GroupCheckInHistory()),
                child: Text(
                  GroupPageRepo.btnSeeAll,
                  style: TextStyle(
                      color: AppConst.magenta,
                      fontSize: sizeConfig.getSize(18),
                      decoration: TextDecoration.underline
                  ),
                ),
              ) :
              SizedBox(),
              SizedBox(height: sizeConfig.height * 10,)
            ],
          ),
        )
      ],
    );
  }

  Widget data(BuildContext context, int index) {
    DemoGroupCheckIn data = demoGroupCheckInData[index];
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
                width: sizeConfig.width * 200,
                height: 2,
              )
          ),
          Expanded(
            child: Center(
              child: Text(
                  data.present.toString(),
                  style: TextStyle(
                      fontSize: sizeConfig.getSize(18),
                      color: Colors.green
                  )
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: sizeConfig.width * 20
            ),
            child: Container(
              color: Colors.grey,
              width: sizeConfig.width * 100,
              height: 2,
            )
          ),
          Expanded(
            child: Center(
              child: Text(
                  data.absent.toString(),
                  style: TextStyle(
                      fontSize: sizeConfig.getSize(18),
                      color: Colors.red
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget membersTab() =>  GridView.builder(
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: sizeConfig.getSize(10),
        mainAxisSpacing: sizeConfig.getSize(10)
    ),
    padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 20, horizontal: sizeConfig.width * 30),
    itemCount: demoGroupMembers.length,
    itemBuilder: userGrid,
  );

  Widget userGrid(BuildContext context, int index) {
    DemoUsersModel user = demoGroupMembers[index];
    return GestureDetector(
      onTap: (){
        Get.dialog(Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(18.0),
                child: Text(
                  'Confirm ?',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: sizeConfig.getSize(28)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  'Are you sure you want to make ${user.fName + ' ' +user.lName} an ADMIN?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: sizeConfig.getSize(20)
                  ),
                ),
              ),
              SizedBox(height: sizeConfig.height * 15,),
              Container(
                height: sizeConfig.height * 80,
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey[400],width: 2),
                    )
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => Get.back(),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.grey[400],width: 2),
                              )
                          ),
                          child: Center(
                            child: Text(
                              'No',
                              style: TextStyle(
                                  fontSize: sizeConfig.getSize(22)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            user.admin = true;
                          });
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(color: Colors.grey[400],width: 2),
                              )
                          ),
                          child: Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                  fontSize: sizeConfig.getSize(22)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
      },
      child: Card(
        child: GridTile(
          child: Column(
            children: [
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user.image),
                radius: sizeConfig.getSize(35),
              ),
              RichText(
                text: TextSpan(
                    text: user.fName,
                    style: TextStyle(
                        fontSize: sizeConfig.getSize(18),
                        color: Colors.black
                    ),
                    children: [
                      TextSpan(text: ' '),
                      TextSpan(
                          text: user.lName[0].toUpperCase()
                      )
                    ]
                ),
              )
            ],
          ),
          footer: user.admin ? Container(
            height: sizeConfig.getSize(10),
            width: sizeConfig.getSize(10),
            color: Colors.red,
          ) : SizedBox(),
        ),
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
        btnOkOnPress: checkInSuccessFull,
        btnCancelOnPress: (){}
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
}
