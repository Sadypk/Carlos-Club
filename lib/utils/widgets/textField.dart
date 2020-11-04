import 'package:flutter/material.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:get/get.dart';

class RoundedTextField extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final String labelText;
  final IconData icon;
  final TextEditingController controller;
  RoundedTextField({
    @required this.labelText,
    @required this.icon,
    @required this.controller
});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeConfig.getSize(60),
      width: sizeConfig.width * 800,
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: Color(0xff4D4F56)
        ),
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(
            icon,
            color: Color(0xff4D4F56),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(111)
          ),
        ),
      ),
    );
  }
}
