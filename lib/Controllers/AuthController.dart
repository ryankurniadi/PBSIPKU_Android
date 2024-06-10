import 'package:get/get.dart';
import '../Routes/PageNames.dart';

class AuthController extends GetxController{
  var isLogin = true.obs;

  loginCheck(){
    isLogin.value = true;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

}