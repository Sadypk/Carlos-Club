import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:flutter_app/utils/widgets/blueButton.dart';
import 'package:flutter_app/utils/widgets/textField.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {

  final GetSizeConfig sizeConfig = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();

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
          'Sign Up',
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
          labelText: 'Name',
          icon: Icons.person_outline,
          controller: nameController,
        ),
        SizedBox(height: sizeConfig.height * 30,),
        RoundedTextField(
          labelText: 'Email',
          icon: Icons.email_outlined,
          controller: emailController,
        ),
        SizedBox(height: sizeConfig.height * 30,),
        RoundedTextField(
          labelText: 'Password',
          icon: Icons.lock_outline,
          controller: passwordController,
        ),
        SizedBox(height: sizeConfig.height * 30,),
        RoundedTextField(
          labelText: 'Confirm Password',
          icon: Icons.lock_outline,
          controller: confPasswordController,
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

  Widget footer() {
    return RichText(
      text: TextSpan(
          text: 'Already have an account?',
          style: TextStyle(
              color: Colors.black
          ),
          children: [
            TextSpan(
                recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                text: 'Sign In',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                )
            )
          ]
      ),
    );
  }
}
