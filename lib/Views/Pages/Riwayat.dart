import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Models/PesertaView.dart';
import '../../Controllers/AuthController.dart';
import '../../Controllers/TurnamenContoller.dart';


class Riwayat extends StatelessWidget {
  Riwayat({super.key});

  final turC = Get.find<TurnamenController>();
  final authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    turC.getUserTur(authC.authUserID.value);
    return SafeArea(child: Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          const SizedBox(
            height: 15,
          ),
          const Row(
            children: [
              Text(
                "Turnamen",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          GetBuilder<TurnamenController>(
            builder: (_) {
              if (turC.totalRiwayat.value <= 0) {
                return const Center(
                  child: Text("Tidak ada riwayat pengajuan turnamen"),
                );
              }
              return ListView.builder(
                //
                itemCount: turC.totalRiwayat.value,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  Pesertaview data = turC.riwayatTur[index];
                  return InkWell(
                    onTap: () async {
          
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 160,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  "${data.img}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${data.namaTur}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "${data.lokasi}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 10),
                                    child: Center(
                                      child: Text(
                                        "${data.level}",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                const Text(
                                  "Status Pengajuan:",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${data.status}",
                                  style: TextStyle(
                                      color: (data.status! == "Pending"
                                          ? Colors.orange
                                          : (data.status! == "Disetujui"
                                              ? Colors.green
                                              : Colors.red)),
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  "Pelaksanaan Turnamen:",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(DateFormat('EEEE, dd MMMM yyyy', 'id')
                                    .format(data.date!)),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    ));
  }
}
