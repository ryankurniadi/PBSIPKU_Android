import 'package:get/get.dart';


class InputHideController extends GetxController{
  var isHide = false.obs;

  inputChange(bool change){
    isHide.value = change;
    update();
  }
}