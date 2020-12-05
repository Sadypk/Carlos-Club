import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/authentication/view/register_page.dart';
import 'package:flutter_app/authentication/repository/auth_repository.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_app/main_app/resources/size_config.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/main_app/util/validator.dart';
import 'package:flutter_app/main_app/widgets/blue_button.dart';
import 'package:flutter_app/main_app/widgets/loader.dart';
import 'package:flutter_app/main_app/widgets/text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final formKey = GlobalKey<FormState>();
  AuthRepository authController = Get.find();
  GetSizeConfig sizeConfig = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  FocusNode emailNode;
  FocusNode passwordNode;

  bool rememberUser = false;
  bool isLoading;

  @override
  initState() {
    super.initState();
    isLoading = false;
    emailNode = FocusNode();
    passwordNode = FocusNode();
    emailNode.addListener(() {setState(() {});});
    passwordNode.addListener(() {setState(() {});});
  }

  @override
  dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();

    emailNode.dispose();
    passwordNode.dispose();
  }

  getSnackbar(hasException){
    Get.snackbar(
      "Error signing in",
      hasException,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      margin: EdgeInsets.only(left: sizeConfig.width * 10,
          right: sizeConfig.width * 10,
          bottom: sizeConfig.height * 15),
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Stack(
        children: [
          IgnorePointer(
            ignoring: isLoading?true:false,
            child: Opacity(
              opacity: isLoading?0.5:1,
              child: Container(
                color: isLoading?Colors.grey[50]:Color(0xffF2F2FF),
                child: Center(
                  child:   SingleChildScrollView(
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
                ),
              ),
            ),
          ),
          isLoading?Loader():Container(),
        ],
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
    return Form(
      key: formKey,
      child: Column(
        children: [
          RoundedTextField(
            autoFocus: false,
            readOnly: false,
            focusNode: emailNode,
            labelText: StringResources.loginTextFieldHintEmail,
            icon: Icons.email,
            controller: emailController,
            validator: Validator().validateEmail,
          ),
          SizedBox(height: sizeConfig.height * 30,),
          RoundedTextField(
            autoFocus: false,
            readOnly: false,
            focusNode: passwordNode,
            labelText: StringResources.loginTextFieldHintPassword,
            icon: Icons.lock,
            controller: passwordController,
            obscureText: true,
            validator: Validator().validateEmptyPassword,
          ),
          SizedBox(height: sizeConfig.height * 20,),
          rememberMe(),
          SizedBox(height: sizeConfig.height * 20,),
          BlueButton(
              text: StringResources.loginBtnLogin,
              onTap: () async {
                FocusScope.of(context).unfocus();
                if(formKey.currentState.validate()){
                  setState(() {
                    isLoading = true;
                  });
                  var hasException =  await authController.login(emailController.text, passwordController.text,rememberUser);
                  if(hasException != null){
                    setState(() {
                      isLoading = false;
                    });
                    getSnackbar(hasException);
                  }
                }
                //login as member by default
              }
          )
        ],
      ),
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
          signUpMethod(StringResources.loginImgSignInWithGoogle, 'google'),
          signUpMethod(StringResources.loginImgSignInWithFacebook, 'facebook'),
        ],
      ),
    );
  }

  Widget signUpMethod(String image, String identifier){
    return GestureDetector(
      onTap: () async {
        if(identifier == 'facebook'){
          setState(() {
            isLoading = true;
          });
          print('Checking Facebook...');
          AuthRepository authFacebook = Get.find();
          var hasException = await authFacebook.loginFacebook();
          if(hasException != null){
            setState(() {
              isLoading = false;
            });
            getSnackbar(hasException);
          }
        }else if(identifier == 'google'){
          setState(() {
            isLoading = true;
          });
          print('Checking Google...');
          AuthRepository authGoogle = Get.find();
          var hasException = await authGoogle.handleGoogleSignIn();
          if(hasException != null){
            setState(() {
              isLoading = false;
            });
            getSnackbar(hasException);
          }
        }
      },
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

}
