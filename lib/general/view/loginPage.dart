import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/general/view/registerPage.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:flutter_app/utils/widgets/blueButton.dart';
import 'package:flutter_app/utils/widgets/textField.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GetSizeConfig sizeConfig = Get.find();
  double height;
  double width;


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Function signUpWithGoogle = () {
    print('sign up with google');
  };
  Function signUpWithFacebook = () {
    print('sign up with facebook');
  };

  @override
  void initState() {
    if(mounted){
      height = sizeConfig.height.value;
      width = sizeConfig.width.value;
      super.initState();
    }else{
      return ;
    }
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
      height: height * 300,
      // color: Colors.red,
      child: Center(
        child: Text(
          'Sign In',
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
          labelText: 'Email',
          icon: Icons.email,
          controller: emailController,
        ),
        SizedBox(height: height * 30,),
        RoundedTextField(
          labelText: 'Password',
          icon: Icons.lock,
          controller: passwordController,
        ),
        SizedBox(height: height * 60,),
        BlueButton(
          text: 'Login',
          onTap: (){
            print(emailController.text);
            print(passwordController.text);
          }
        )
      ],
    );
  }

  Widget signUpMethods() {
    return Container(
      height: height * 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          signUpMethod('assets/images/signUpMethods/google.png', signUpWithGoogle),
          signUpMethod('assets/images/signUpMethods/facebook.png', signUpWithFacebook),
        ],
      ),
    );
  }

  Widget footer() {
    return RichText(
      text: TextSpan(
        text: 'Don\'t have an account?',
        style: TextStyle(
          color: Colors.black
        ),
        children: [
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () => Get.to(RegisterPage()),
            text: 'Sign up',
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
