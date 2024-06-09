import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Models/Turnamen.dart';

class TurnamenController extends GetxController {
  final db = FirebaseFirestore.instance;
  var id = "".obs;
  var nama = "".obs;
  var img = "".obs;
  var ket = "".obs;
  var status = "".obs;
  var date = DateTime.now().obs;
  var totalTur = 0.obs;
  var dateShow = "".obs;
  var level = "Level A".obs;

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
            level: docSnap.docs[i].data().level,
          ));
        }
        print(totalTur);
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  void addData() async {
    final ref = db.collection(table).withConverter(
        fromFirestore: Turnamen.fromFirestore,
        toFirestore: (Turnamen turnamen, _) => turnamen.toFirestore());
    try {
      await ref.add(
        Turnamen(
          nama: nama.value,
          date: date.value,
          status: "Publish",
          ket: ket.value,
          level: level.value,
          img: "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/badminton%2C-badminton-tournament%2Cevent-design-template-bcd5e2bb9c5b1c573406ef92af89d9d8.jpg?ts=1637014235"
        ),
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

  void deleteData(String id)async{
     try {
      await db.collection(table).doc(id).delete();
      getData();
      Get.back();
      Get.snackbar("Berhasil", "Data Berhasil Di Hapus",
          backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar("Gagal", "Data Gagal Di Hapus", backgroundColor: Colors.red);
    }
  }


  void setDate(DateTime tgl) {
    date.value = tgl;
    showDate(tgl);
    update();
  }

  void showDate(DateTime tgl){
    dateShow.value = "${DateFormat("EEEE, dd MMMM yyyy", "id").format(tgl)}";
    update();
  }

  @override
  void onInit() {
    getData();
    showDate(DateTime.now());
    super.onInit();
  }
}
