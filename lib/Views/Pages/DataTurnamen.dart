import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/NavBar.dart';
import '../Widgets/Sidebar.dart';
import '../../Routes/PageNames.dart';
import '../../Models/Turnamen.dart';
import '../../Controllers/TurnamenContoller.dart';

class DataTurnamen extends StatelessWidget {
  DataTurnamen({super.key});
  final turC = Get.put(TurnamenController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const NavBar(title: "Data Turnamen Kota Pekanbaru"),
        drawer: const Sidebar(),
        body: ListView(
          shrinkWrap: true,
          children: [
            const Center(
              child: Text("Data Turnamen"),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {Get.toNamed(PageNames.AddTurnamen);}, child: const Text("Tambah Data Turnamen")),
                const SizedBox(height: 10,),
            GetBuilder<TurnamenController>(
              builder: (turC) {
                if(turC.totalTur.value > 0){
                  return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: turC.totalTur.value,
                  itemBuilder: (context, index) {
                    Turnamen dataTur = turC.dataTurnamen[index];
                    return ListTile(
                      title: Text("${dataTur.nama}"),
                    );
                  },
                );
                }else{
                  return Center(child: const Text("No Data"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
