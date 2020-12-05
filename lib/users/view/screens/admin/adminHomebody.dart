import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/main_app/widgets/logout_dialog.dart';
import 'package:flutter_app/users/models/demos.dart';
import 'package:flutter_app/users/view/screens/admin/absentAndPresentList.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_app/main_app/widgets/text_field.dart';
import 'package:flutter_app/users/view_model/user_profile_view_model.dart';
import 'package:get/get.dart';

class AdminHomeBody extends StatefulWidget {
  @override
  _AdminHomeBodyState createState() => _AdminHomeBodyState();
}

class _AdminHomeBodyState extends State<AdminHomeBody> {
  final GetSizeConfig sizeConfig = Get.find();

  UserDataController userDataController = Get.find();

  TextEditingController emailController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {setState(() {});});
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.symmetric(vertical: sizeConfig.getSize(4),horizontal: sizeConfig.getSize(10)),
            child: CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(userDataController.userData.value.userPhoto??StringResources.memberHomeScreenProfilePic),
            ),
          ),
          title: Text('Welcome: ${userDataController.userData.value.userName}'),
          elevation: 0,
          bottom: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            title: TabBar(
              labelColor: AppConst.magenta,
              unselectedLabelColor: Colors.grey[500],
              labelStyle: TextStyle(
                  fontSize: sizeConfig.getSize(18),
                  fontWeight: FontWeight.bold
              ),
              unselectedLabelStyle: TextStyle(
                  fontSize: sizeConfig.getSize(18)
              ),
              tabs: [
                Tab(text: 'Present',),
                Tab(text: 'Absent',),
              ],
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlatButton(
                  onPressed: addMember,
                  color: Colors.green,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add,color: Colors.white,),
                      Text('Add User',style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
              )
            ],
          ),
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
        body: AbsentAndPresentListScreen(),
      ),
    );
  }

  addMember(){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.INFO,
        animType: AnimType.TOPSLIDE,
        body: StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return DefaultTabController(
              length: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TabBar(
                    unselectedLabelColor: Colors.grey[500],
                    labelColor: Colors.blue,
                    tabs: [
                      Tab(text: 'Email',),
                      Tab(text: 'List',),
                    ],
                  ),
                  Container(
                    height: sizeConfig.height * 300,
                    child: TabBarView(
                      children: [
                        Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Enter User Email :',
                                      style: TextStyle(
                                          fontSize: sizeConfig.getSize(24)
                                      ),
                                    ),
                                    SizedBox(height: sizeConfig.height * 20,),
                                    RoundedTextField(
                                        labelText: 'User email',
                                        icon: Icons.email_outlined,
                                        controller: emailController,
                                        focusNode: focusNode,
                                      autoFocus: false,
                                      readOnly: false,
                                    )
                                  ]
                              ),
                            )
                        ),
                        Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: demoGroupMembers.length,
                              itemBuilder: (_, index){
                                DemoUsersModel user = demoGroupMembers[index];
                                return Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: CachedNetworkImageProvider(
                                          user.image
                                      ),
                                    ),
                                    title: Text(
                                      user.fName + ' ' + user.lName
                                    ),
                                    trailing: IconButton(
                                        onPressed: (){
                                          Get.back();
                                          dialog('Success', '${user.fName + ' ' + user.lName} has been added to your group');
                                        },
                                        icon: Icon(Icons.add)
                                    ),
                                  ),
                                );
                              },
                            )
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
        btnOkOnPress: (){},
        btnCancelOnPress: (){}
    )..show();
  }

  dialog(title,desc){
    AwesomeDialog(
        context: context,
        dialogType: title == 'Success' ? DialogType.SUCCES : DialogType.ERROR,
        animType: AnimType.TOPSLIDE,
        title: title,
        desc: desc,
        btnOkOnPress: (){},
        btnCancelOnPress: (){}
    )..show();
  }

  /// OLD design
/*  SingleChildScrollView(
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
  )

  Widget qrScanners() {
    return Padding(
      padding: EdgeInsets.only(bottom: sizeConfig.height * 10),
      child: FlatButton(
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
                itemCount: demoCheckInData.length > 10 ? 10 :  demoCheckInData.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: sizeConfig.height * 10),
                itemBuilder: data,
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
  }*/
}