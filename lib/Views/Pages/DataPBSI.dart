import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/NavBar.dart';
import '../../Routes/PageNames.dart';
import '../Widgets/Sidebar.dart';
import '../../Models/PBSI.dart';
import '../../Controllers/PBSIController.dart';

class DataPBSI extends StatelessWidget {
  DataPBSI({super.key});
  final pbsiC = Get.find<PBSIController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const NavBar(title: "Data PBSI Pekanbaru"),
      drawer: const Sidebar(),
      body: ListView(
        shrinkWrap: true,
        children: [
          const Center(
            child: Text("DATA DARI FIREBASE"),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  Get.toNamed(PageNames.AddPBSI);
                },
                child: const Text("TAMBAH DATA")),
          ),
          const SizedBox(
            height: 20,
          ),
          GetBuilder<PBSIController>(
            builder: (pbsiC) {
              if (pbsiC.totalPBSI > 0) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: pbsiC.totalPBSI.value,
                  itemBuilder: (context, index) {
                    PBSI data = pbsiC.dataPBSI[index];
                    return ListTile(
                      onTap: () {},
                      title: Text("${data.nama}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.toNamed(PageNames.EditPBSI);
                                pbsiC.id.value = "${data.id}";
                                pbsiC.nama.value = "${data.nama}";
                              },
                              icon: const Icon(
                                Icons.edit,
                                size: 20,
                              )),
                          IconButton(
                              onPressed: () {
                                Get.defaultDialog(
                                    title: "Konfirmasi Hapus",
                                    content: Text(
                                        "Apakah kamu yakin untuk menghapus data ${data.nama}?"),
                                    barrierDismissible: false,
                                    cancel: TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text("Tidak")),
                                    confirm: TextButton(
                                        onPressed: () {
                                          if (!Get.isSnackbarOpen) {
                                            pbsiC.deleteData("${data.id}");
                                          }
                                          
                                        },
                                        child: const Text("Iya")));
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 20,
                              ))
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Text("No Data");
              }
            },
          ),
        ],
      ),
    ));
  }
}
