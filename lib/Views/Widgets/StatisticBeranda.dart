import 'package:flutter/material.dart';

class StatisticBeranda extends StatelessWidget {
  StatisticBeranda({super.key, required this.totalData, required this.namaData, required this.icon, required this.gradien});
  int totalData;
  String namaData;
  IconData icon;
  Gradient gradien;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 140,
        width: 300,
        child: Card(
          child: Container(
            decoration: BoxDecoration(
                gradient: gradien,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 90,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$totalData",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                          Text(
                            namaData,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
