import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/appConst.dart';
import 'package:flutter_app/main_app/resources/sizeConfig.dart';
import 'package:get/get.dart';

class BlueButton extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  final String text;
  final Function onTap;
  BlueButton({
    @required this.text,
    @required this.onTap
});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: sizeConfig.getSize(60),
        width: sizeConfig.width * 500,
        decoration: BoxDecoration(
          color: AppConst.blue,
          borderRadius: BorderRadius.circular(111)
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: sizeConfig.getSize(22)
            ),
          ),
        ),
      ),
    );
  }
}
