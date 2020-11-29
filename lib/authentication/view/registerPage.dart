import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/sizeConfig.dart';
import 'package:flutter_app/main_app/resources/string_resources.dart';
import 'package:flutter_app/main_app/widgets/blueButton.dart';
import 'package:flutter_app/main_app/widgets/textField.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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

  File image;

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
      height: sizeConfig.height * 200,
      // color: Colors.red,
      child: Center(
        child: Text(
          StringResources.registrationHeader,
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
        Stack(
          children: [
            CircleAvatar(
              radius: sizeConfig.getSize(45),
              backgroundImage: image == null ? AssetImage(
                'assets/images/demo_profile_image.jpg'
              ) : FileImage(image),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: selectPic,
                child: CircleAvatar(
                  radius: sizeConfig.getSize(20),
                  backgroundColor: Colors.white60,
                  child: Icon(Icons.camera_alt_outlined),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: sizeConfig.height * 10,),
        RoundedTextField(
          focusNode: nameNode,
          labelText: StringResources.registrationTextFieldHintName,
          icon: Icons.person_outline,
          controller: nameController,
        ),
        SizedBox(height: sizeConfig.height * 10,),
        RoundedTextField(
          focusNode: emailNode,
          labelText: StringResources.registrationTextFieldHintEmail,
          icon: Icons.email_outlined,
          controller: emailController,
        ),
        SizedBox(height: sizeConfig.height * 10,),
        RoundedTextField(
          focusNode: passwordNode,
          labelText: StringResources.registrationTextFieldHintPassword,
          icon: Icons.lock_outline,
          controller: passwordController,
          obscureText: true,
        ),
        SizedBox(height: sizeConfig.height * 10,),
        RoundedTextField(
          focusNode: confPassNode,
          labelText: StringResources.registrationTextFieldHintConfirmPassword,
          icon: Icons.lock_outline,
          controller: confPasswordController,
          obscureText: true,
        ),
        SizedBox(height: sizeConfig.height * 30,),
        signUpMethods(),
        SizedBox(height: sizeConfig.height * 30,),
        BlueButton(
            text: StringResources.registrationBtnRegister,
            onTap: (){
              print(emailController.text);
              print(passwordController.text);
            }
        )
      ],
    );
  }

  Function signUpWithGoogle = (){};
  Function signUpWithFacebook = (){};

  Widget signUpMethods() {
    return Container(
      height: sizeConfig.height * 70,
      width: sizeConfig.width * 600,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            StringResources.registrationTsignUpMethodText,
            style: TextStyle(
              fontSize: sizeConfig.getSize(16)
            ),
          ),
          signUpMethod(StringResources.loginImgSignInWithGoogle, signUpWithGoogle),
          signUpMethod(StringResources.loginImgSignInWithFacebook, signUpWithFacebook),
        ],
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
              radius: sizeConfig.getSize(15),
            )
        ),
      ),
    );
  }

  Widget footer() {
    return RichText(
      text: TextSpan(
          text: StringResources.registrationFooterTextNormal,
          style: TextStyle(
              color: Colors.black
          ),
          children: [
            TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                text: StringResources.registrationFooterTextBold,
                style: TextStyle(
                    fontWeight: FontWeight.bold
                )
            )
          ]
      ),
    );
  }








  void selectPic() async{
    final picker = ImagePicker();
    try{
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          image = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    }catch(e){
      print(e.toString());
    }
  }
}
