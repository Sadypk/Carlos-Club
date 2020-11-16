import 'package:flutter/material.dart';
import 'package:flutter_app/utils/sizeConfig.dart';
import 'package:get/get.dart';
import 'package:marquee/marquee.dart';

class MovingText extends StatelessWidget {
  final GetSizeConfig sizeConfig = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: sizeConfig.height * 40,
      child: Marquee(
        text: 'Some sample text that takes some space.',
        style: TextStyle(
            color: Colors.white,
            fontSize: sizeConfig.getSize(22)
        ),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.start,
        blankSpace: 20.0,
        velocity: 50.0,
        pauseAfterRound: Duration(seconds: 1),
        startPadding: 10.0,
        accelerationDuration: Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}
