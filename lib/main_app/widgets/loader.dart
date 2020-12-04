import 'package:flutter/material.dart';
import 'package:flutter_app/main_app/resources/app_const.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitFoldingCube(
      color: AppConst.magenta,
    );
  }
}
