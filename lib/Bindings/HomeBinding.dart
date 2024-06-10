import 'package:get/get.dart';

import '../Controllers/PBSIController.dart';
import '../Controllers/AuthController.dart';
import '../Controllers/LoadingController.dart';

class HomeBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(LoadingController());
    Get.put(PBSIController());
    Get.put(AuthController());
  }

}