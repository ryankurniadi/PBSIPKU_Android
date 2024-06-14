import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Routes/PageNames.dart';
import '../../Controllers/PBSIController.dart';
import '../../Controllers/SidebarContoller.dart';
import '../../Controllers/AuthController.dart';
import '../../Controllers/UserController.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pbsiC = Get.put(PBSIController());
  final userC = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    userC.getSingleUser();
    return SafeArea(child: Scaffold());
  }
}
