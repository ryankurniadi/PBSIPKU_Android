import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/NavBar.dart';
import '../../Controllers/TurnamenContoller.dart';


class AddTurnamner extends StatelessWidget {
  AddTurnamner({super.key});

  final turC = Get.find<TurnamenController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: const NavBar(title: "Tambah Turnamen"),
      body: ListView(
        children: [
          
        ],
      ),
    ));
  }
}