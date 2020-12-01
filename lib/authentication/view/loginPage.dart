import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/authentication/models/userType.dart';
import 'package:flutter_app/main_app/resources/sizeConfig.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/users/view/screens/admin/adminHomeScreen.dart';
import 'package:flutter_app/authentication/view/registerPage.dart';
import 'package:flutter_app/users/view/screens/members/memberHomeScreen.dart';
import 'package:flutter_app/main_app/resources/appConst.dart';
import 'package:flutter_app/main_app/widgets/blueButton.dart';
import 'package:flutter_app/main_app/widgets/textField.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GetSizeConfig sizeConfig = Get.find();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final Function signUpWithGoogle = () {

    GetUserType userType = Get.find();
    userType.setType(UserType.normal);
    Get.offAll(MemberHomeScreen());
  };

  final Function signUpWithFacebook = () {
    GetUserType userType = Get.find();
    userType.setType(UserType.admin);
    Get.offAll(AdminHomeScreen());
  };

  FocusNode emailNode;
  FocusNode passwordNode;

  bool rememberUser = false;

  @override
  void initState() {
    super.initState();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    emailNode.addListener(() {setState(() {});});
    passwordNode.addListener(() {setState(() {});});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            header(),
            form(),
            signUpMethods(),
            footer()
          ],
        ),
      ),
    );
  }

  Widget header() {
    return Container(
      height: sizeConfig.height * 300,
      // color: Colors.red,
      child: Center(
        child: Text(
          StringResources.loginHeaderText,
          style: TextStyle(
              fontSize: sizeConfig.getSize(34),
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Column(
      children: [
        RoundedTextField(
          focusNode: emailNode,
          labelText: StringResources.loginTextFieldHintEmail,
          icon: Icons.email,
          controller: emailController,
        ),
        SizedBox(height: sizeConfig.height * 30,),
        RoundedTextField(
          focusNode: passwordNode,
          labelText: StringResources.loginTextFieldHintPassword,
          icon: Icons.lock,
          controller: passwordController,
          obscureText: true
        ),
        SizedBox(height: sizeConfig.height * 20,),
        rememberMe(),
        SizedBox(height: sizeConfig.height * 20,),
        BlueButton(
            text: StringResources.loginBtnLogin,
            onTap: (){Get.offAll(MemberHomeScreen());}
        )
      ],
    );
  }

  Widget rememberMe() => Row(
    children: [
      SizedBox(width: sizeConfig.width * 100,),
      GestureDetector(
        onTap: (){
          setState(() {
            rememberUser = !rememberUser;
          });
        },
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(vertical: sizeConfig.height * 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: sizeConfig.width * 20,),
              SizedBox(
                height: sizeConfig.height * 20,
                width: sizeConfig.height * 20,
                child: Checkbox(
                  onChanged: (value){
                    setState(() {
                      rememberUser = value;
                    });
                  },
                  value: rememberUser,
                  activeColor: AppConst.green,
                ),
              ),
              SizedBox(width: sizeConfig.width * 20,),
              Text(
                'Remember me',
                style: TextStyle(
                    fontSize: sizeConfig.getSize(14),
                    color: rememberUser ? AppConst.green : Colors.black
                ),
              )
            ],
          ),
        ),
      ),
      Spacer()
    ],
  );

  Widget signUpMethods() {
    return Container(
      height: sizeConfig.height * 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          signUpMethod(StringResources.loginImgSignInWithGoogle, signUpWithGoogle),
          signUpMethod(StringResources.loginImgSignInWithFacebook, signUpWithFacebook),
        ],
      ),
    );
  }

  Widget footer() {
    return RichText(
      text: TextSpan(
          text: StringResources.loginFooterTextNormal,
          style: TextStyle(
              color: Colors.black
          ),
          children: [
            TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.to(RegisterPage()),
                text: StringResources.loginFooterTextBold,
                style: TextStyle(
                    fontWeight: FontWeight.bold
                )
            )
          ]
      ),
    );
  }

  Widget signUpMethod(String image, Function onTap){
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(111)),
        child: Padding(
            padding: EdgeInsets.all(sizeConfig.getSize(4)),
            child: CircleAvatar(
              backgroundImage: AssetImage(image),
              backgroundColor: Colors.transparent,
              radius: sizeConfig.getSize(30),
            )
        ),
      ),
    );
  }
}