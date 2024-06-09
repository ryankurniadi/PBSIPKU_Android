import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/NavBar.dart';
import '../Widgets/Sidebar.dart';
import '../../Controllers/PBSIController.dart';

class Home extends StatelessWidget {
  Home({super.key});
  final pbsiC = Get.put(PBSIController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: NavBar(title: "PBSI KOTA PEKANBARU"),
        drawer: const Sidebar(),
        
      ),
    );
  }
}