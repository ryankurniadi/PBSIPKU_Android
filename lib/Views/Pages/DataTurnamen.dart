import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:get/get.dart';

import '../../Models/Turnamen.dart';
import '../../Controllers/TurnamenContoller.dart';
import '../../Routes/PageNames.dart';

class DataTrunamen extends StatefulWidget {
  DataTrunamen({super.key});

  @override
  State<DataTrunamen> createState() => _DataTrunamenState();
}

class _DataTrunamenState extends State<DataTrunamen> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final turC = Get.find<TurnamenController>();

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    turC.getData();
    return Scaffold(
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
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        GetBuilder<TurnamenController>(
          builder: (turC) {
            if (turC.dataTurnamen.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: turC.dataTurnamen.length,
                itemBuilder: (context, index) {
                  Turnamen data = turC.dataTurnamen[index];
                  return InkWell(
                    onTap: () async {
                      turC.turID.value = data.id!;
                      await turC.getSingleTur();
                      Get.toNamed(PageNames.DetailTurnamen);
                    },
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 140,
                              height: 180,
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
                                Container(
                                  constraints:
                                      BoxConstraints(maxWidth: Get.width / 1.9),
                                  child: Text(
                                    "${data.nama}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  constraints:
                                      BoxConstraints(maxWidth: Get.width / 2),
                                  child: Text(
                                    "${data.lokasi}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 10),
                                        child: Center(
                                          child: Text(
                                            "${data.level}",
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 10),
                                        child: Center(
                                          child: Text(
                                            (data.biaya == 0
                                                ? "Gratis"
                                                : NumberFormat.currency(
                                                        locale: 'id',
                                                        symbol: 'Rp. ',
                                                        decimalDigits: 0)
                                                    .format(data.biaya)),
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.purple,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 13),
                                    child: Center(
                                      child: (data.tipe == "Publik"
                                          ? Text(
                                              "${data.tipe}",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          : const Text(
                                              "Internal PBSI",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
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
                                const SizedBox(
                                  height: 3,
                                ),
                                const Text(
                                  "Batas Pendaftaran:",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(DateFormat('EEEE, dd MMMM yyyy', 'id')
                                    .format(data.batas!)),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Tidak Ada Turnamen yang tersedia di Level Anda"),
              );
            }
          },
        ),
      ],
    ));
  }
}
