import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/Turnamen.dart';

class TurnamenController extends GetxController {
  final db = FirebaseFirestore.instance;
  var id = "".obs;
  var nama = "".obs;
  var img = "".obs;
  var ket = "".obs;
  var status = "".obs;
  var date = "".obs;
  var totalTur = 0.obs;

  var dataTurnamen = [].obs;

  var table = 'turnamen';

  void getData() async {
    final ref = db.collection(table).withConverter(
        fromFirestore: Turnamen.fromFirestore,
        toFirestore: (Turnamen turnamen, _) => turnamen.toFirestore());
    try {
      final docSnap = await ref.orderBy('date').get();
      if (docSnap.docs.isNotEmpty) {
        dataTurnamen.clear();
        totalTur.value = docSnap.docs.length;
        for (var i = 0; i < docSnap.docs.length; i++) {
          dataTurnamen.add(Turnamen(
            id: docSnap.docs[i].id,
            nama: docSnap.docs[i].data().nama,
            img: docSnap.docs[i].data().img,
            ket: docSnap.docs[i].data().ket,
            status: docSnap.docs[i].data().status,
            date: docSnap.docs[i].data().date,
          ));
        }
        update();
      }
    } catch (e) {
      print(e);
    }

    void addData() async {
      final ref = db.collection(table).withConverter(
          fromFirestore: Turnamen.fromFirestore,
          toFirestore: (Turnamen turnamen, _) => turnamen.toFirestore());
      try {
        await ref.add(
          Turnamen(),
        );
        getData();
        Get.back();
        Get.snackbar("Berhasil", "Data Berhasil Di tambah",
            backgroundColor: Colors.green);
      } catch (e) {
        Get.snackbar("Gagal", "Data Gagal Di Tambah",
            backgroundColor: Colors.red);
      }
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
