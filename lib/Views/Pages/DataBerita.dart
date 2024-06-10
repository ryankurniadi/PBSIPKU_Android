import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/NavBar.dart';

class DataBerita extends StatelessWidget {
  DataBerita({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const NavBar(title: "Data Berita"),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          ElevatedButton(
              onPressed: () {
                //Get.toNamed(PageNames.AddTurnamen);
              },
              child: const Text("Buat Berita Terbaru")),
        ],
      ),
    ));
  }
}
