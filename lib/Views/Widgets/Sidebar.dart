import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Routes/PageNames.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        Container(
          height: 150,
          color: Colors.amber,
        ),
        ListTile(
          onTap: () {
            Get.back();
            Get.toNamed(PageNames.Home);
          },
          title: const Text("Beranda"),
          leading: const Icon(Icons.home, size: 20,),
        ),
        ListTile(
          onTap: () {
            Get.back();
            Get.toNamed(PageNames.DataPBSI);
          },
          title: const Text("Data PBSI"),
          leading: const Icon(Icons.sports, size: 20,),
        ),
        ListTile(
          onTap: () {
            Get.back();
            Get.toNamed(PageNames.DataTurnamen);
          },
          title: const Text("Turnamen"),
          leading: const Icon(Icons.flag, size: 20,),
        ),
        ListTile(
          onTap: () {
            Get.back();
            Get.toNamed(PageNames.Blank);
          },
          title: const Text("Blank Page"),
          leading: const Icon(Icons.paste, size: 20,),
        ),
        ListTile(
          onTap: () {
            Get.back();
            Get.toNamed(PageNames.Login);
          },
          title: const Text("Login"),
          leading: const Icon(Icons.paste, size: 20,),
        ),
      ],
    ));
  }
}
