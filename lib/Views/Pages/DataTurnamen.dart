import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Widgets/NavBar.dart';
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
        appBar: NavBar(title: "Data Turnamen Kota Pekanbaru"),
        //drawer: const Sidebar(),
        body: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(PageNames.AddTurnamen);
                },
                child: const Text("Tambah Data Turnamen")),
            const SizedBox(
              height: 10,
            ),
            GetBuilder<TurnamenController>(
              builder: (turC) {
                if (turC.totalTur.value > 0) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: turC.totalTur.value,
                    itemBuilder: (context, index) {
                      Turnamen dataTur = turC.dataTurnamen[index];
                      return ListTile(
                        title: Text("${dataTur.nama}"),
                        leading: Image(image: NetworkImage(dataTur.img!, ), width: 100, height: 100,),
                        subtitle: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${dataTur.level}"),
                            Text("${DateFormat('EEEE, dd MMMM yyyy', 'id').format(dataTur.date!)}")
                          ],
                        ),
                        onTap: (){},
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(onPressed: ()async{
                              turC.turID.value = "${dataTur.id}";
                              await turC.getSingleTur();
                              Get.toNamed(PageNames.EditTurnamen);
                            }, icon: const Icon(Icons.edit)),
                            IconButton(onPressed: (){
                              Get.defaultDialog(
                              title: "Konfirmasi Hapus",
                              content: Text("Apakah kamu yakin untuk menghapus data ${dataTur.nama}?"),
                              barrierDismissible: false,
                              cancel: TextButton(onPressed: (){
                                Get.back();
                              }, child: const Text("Tidak")),
                              confirm: TextButton(onPressed: (){
                                if(!Get.isSnackbarOpen){
                                   turC.deleteData("${dataTur.id}", "${dataTur.img}");
                                }
                               
                              }, child: const Text("Iya"))
                            );
                            }, icon: const Icon(Icons.delete)),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: const Text("No Data"));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
