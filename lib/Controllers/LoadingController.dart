import 'package:get/get.dart';

class LoadingController extends GetxController{
  var isLoading = false.obs;
  
  changeLoading(bool stat){
    isLoading.value = stat;
    update();
  }
}