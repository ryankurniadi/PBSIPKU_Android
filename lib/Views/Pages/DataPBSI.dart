import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/NavBar.dart';
import '../../Routes/PageNames.dart';
import '../../Models/PBSI.dart';
import '../../Controllers/PBSIController.dart';

class DataPBSI extends StatelessWidget {
  DataPBSI({super.key});
  final pbsiC = Get.find<PBSIController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: NavBar(title: "Data PBSI Pekanbaru"),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Row(
            children: [
              InkWell(
                  onTap: () {
                    Get.toNamed(PageNames.AddPBSI);
                  },
                  child: Container(
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xff197500), Color(0xff007529)],
                            stops: [0, 1],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: Colors.white,),
                          SizedBox(width: 10,),
                          Text("TAMBAH DATA", style: TextStyle(color: Colors.white),),
                        ],
                      )))),
            ],
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
