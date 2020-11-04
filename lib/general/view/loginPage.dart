import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/general/view/registerPage.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:flutter_app/utils/widgets/blueButton.dart';
import 'package:flutter_app/utils/widgets/textField.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Function signUpWithGoogle = () {
    print('sign up with google');
  };
  final Function signUpWithFacebook = () {
    print('sign up with facebook');
  };

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
        SizedBox(height: sizeConfig.height * 30,),
        RoundedTextField(
          labelText: 'Password',
          icon: Icons.lock,
          controller: passwordController,
        ),
        SizedBox(height: sizeConfig.height * 60,),
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
      height: sizeConfig.height * 250,
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
