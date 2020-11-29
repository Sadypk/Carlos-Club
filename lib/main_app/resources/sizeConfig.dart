import 'package:get/get.dart';

class GetSizeConfig extends GetxController{
  RxDouble height = 0.0.obs;
  RxDouble width = 0.0.obs;

  setConfig(h,w){
    height.value = h;
    width.value = w;
  }

  getSize(px){
    return width.value * (px/width.value);
  }
}