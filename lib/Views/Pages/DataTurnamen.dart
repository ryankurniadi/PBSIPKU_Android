import 'package:flutter/material.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:get/get.dart';

import '../../Models/Turnamen.dart';
import '../../Controllers/TurnamenContoller.dart';

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
    return Scaffold(body: SmartRefresher(
      controller: _refreshController,
      onLoading: ()async{
        await turC.getData();
        _refreshController.loadComplete();
      },
      onRefresh: (){
        _refreshController.refreshCompleted();
      },
      child: GetBuilder<TurnamenController>(
        builder: (turC) {
          if (turC.totalTur.value > 0) {
            return ListView.builder(
              itemCount: turC.totalTur.value,
              itemBuilder: (context, index) {
                Turnamen data = turC.dataTurnamen[index];
                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Image(
                              image: NetworkImage("${data.img}"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${data.nama}"),
                                Text("${data.level}"),
                                Text("${data.lokasi}"),
                              ],
                            ),
                          )
                        ],
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
    ));
  }
}
