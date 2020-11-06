import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/general/view_model/registerPage.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:flutter_app/utils/widgets/blueButton.dart';
import 'package:flutter_app/utils/widgets/textField.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GetSizeConfig sizeConfig = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();

  FocusNode nameNode;
  FocusNode emailNode;
  FocusNode passwordNode;
  FocusNode confPassNode;

  @override
  void initState() {
    super.initState();
    nameNode = FocusNode();
    emailNode = FocusNode();
    passwordNode = FocusNode();
    confPassNode = FocusNode();
    nameNode.addListener(() {setState(() {});});
    emailNode.addListener(() {setState(() {});});
    passwordNode.addListener(() {setState(() {});});
    confPassNode.addListener(() {setState(() {});});
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
            SizedBox(height: sizeConfig.height * 50,),
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
          RegisterPageViewModel.header,
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
          focusNode: nameNode,
          labelText: RegisterPageViewModel.textFieldHintName,
          icon: Icons.person_outline,
          controller: nameController,
        ),
        SizedBox(height: sizeConfig.height * 30,),
        RoundedTextField(
          focusNode: emailNode,
          labelText: RegisterPageViewModel.textFieldHintEmail,
          icon: Icons.email_outlined,
          controller: emailController,
        ),
        SizedBox(height: sizeConfig.height * 30,),
        RoundedTextField(
          focusNode: passwordNode,
          labelText: RegisterPageViewModel.textFieldHintPassword,
          icon: Icons.lock_outline,
          controller: passwordController,
        ),
        SizedBox(height: sizeConfig.height * 30,),
        RoundedTextField(
          focusNode: confPassNode,
          labelText: RegisterPageViewModel.textFieldHintConfirmPassword,
          icon: Icons.lock_outline,
          controller: confPasswordController,
        ),
        SizedBox(height: sizeConfig.height * 60,),
        BlueButton(
            text: RegisterPageViewModel.btnRegister,
            onTap: (){
              print(emailController.text);
              print(passwordController.text);
            }
        )
      ],
    );
  }

  Widget footer() {
    return RichText(
      text: TextSpan(
          text: RegisterPageViewModel.footerTextNormal,
          style: TextStyle(
              color: Colors.black
          ),
          children: [
            TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                text: RegisterPageViewModel.footerTextBold,
                style: TextStyle(
                    fontWeight: FontWeight.bold
                )
            )
          ]
      ),
    );
  }
}
