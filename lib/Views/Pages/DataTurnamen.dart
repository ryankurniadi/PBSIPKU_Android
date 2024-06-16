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
        body: SmartRefresher(
      controller: _refreshController,
      onLoading: () async {
        await turC.getData();
        _refreshController.loadComplete();
      },
      onRefresh: () {
        _refreshController.refreshCompleted();
      },
      child: GetBuilder<TurnamenController>(
        builder: (turC) {
          if (turC.totalTur.value > 0) {
            return ListView.builder(
              
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              itemCount: turC.totalTur.value,
              itemBuilder: (context, index) {
                Turnamen data = turC.dataTurnamen[index];
                return InkWell(
                  onTap: () async{
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
                                "${data.nama}",
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
                                "Pelaksanaan Turnamen:",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(DateFormat('EEEE, dd MMMM yyyy', 'id')
                                  .format(data.date!)),
                              const SizedBox(height: 3,),
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
                      const SizedBox(height: 15,)
,                    ],
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
    ));
  }
}
