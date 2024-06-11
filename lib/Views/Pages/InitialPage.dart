import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './Home.dart';
import './LoginPage.dart';
import '../../Controllers/AuthController.dart';
import '../../Controllers/LoadingController.dart';
import '../../Controllers/SidebarContoller.dart';

class Initialpage extends StatelessWidget {
  Initialpage({super.key});
  final loadC = Get.put(LoadingController());
  final sideC = Get.put(SidebarController());
  final authC = Get.put(AuthController());
  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (authC){
        if(authC.isLogin.value){
          return Home();
        }else{
          return LoginPage();
        }
      }
    );
  }
}