import 'package:flutter/material.dart';
import 'package:flutter_app/utils/appConst.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:get/get.dart';

class RoundedTextField extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool obscureText;
  RoundedTextField({
    @required this.labelText,
    @required this.icon,
    @required this.controller,
    @required this.focusNode,
    this.obscureText = false
});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeConfig.getSize(60),
      width: sizeConfig.width * 800,
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(
          color: Color(0xff4D4F56)
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            color: focusNode.hasFocus ? AppConst.green : AppConst.darkGrey
          ),
          prefixIcon: Icon(
            icon,
            color: focusNode.hasFocus ? AppConst.green : AppConst.darkGrey,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(111),
            borderSide: BorderSide(
              color: AppConst.green
            )
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(111)
          ),
        ),
      ),
    );
  }
}
