import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Models/Turnamen.dart';
import './LoadingController.dart';
import '../Controllers/UserController.dart';

class TurnamenController extends GetxController {
  final userC = Get.find<UserController>();
  final db = FirebaseFirestore.instance;
  final Rx<Uint8List?> imageBytes = Uint8List(0).obs;
  var id = "".obs;
  var img = "".obs;
  var ket = "".obs;
  var level = "Level A".obs;
  var link = "".obs;
  var nama = "".obs;
  var status = "".obs;
  var table = 'turnamen';
  var lokasi = "".obs;
  var totalTur = 0.obs;
  var pbsi = "".obs;
  var dataTurnamen = [].obs;
  var date = DateTime.now().obs;
  var date2 = DateTime.now().obs;
  var dateShow = "".obs;
  var dateShow2 = "".obs;
  var statusupload = true.obs;

  var turID = "".obs;
  var dataSatuTur = [].obs;
  var isEditImg = false.obs;
  var terDaftar = false.obs;

  final loadC = Get.find<LoadingController>();

  @override
  void onInit() {
    //getData();
    showDate(DateTime.now());
    showDate2(DateTime.now());
    super.onInit();
  }

  getData() async {
    ket.value = "";
    final ref = db.collection(table).withConverter(
        fromFirestore: Turnamen.fromFirestore,
        toFirestore: (Turnamen turnamen, _) => turnamen.toFirestore());
    try {
      final docSnap = await ref
          .where("level".toString(), isEqualTo: userC.userProfil!.skill)
          .orderBy('date')
          .get();
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
            batas: docSnap.docs[i].data().batas,
            pbsi: docSnap.docs[i].data().pbsi,
            lokasi: docSnap.docs[i].data().lokasi,
            limit: docSnap.docs[i].data().limit,
            kontak: docSnap.docs[i].data().kontak,
            tipe: docSnap.docs[i].data().tipe,
          ));
        }
      } else {
        dataTurnamen.clear();
        totalTur.value = 0;
      }
      update();
    } catch (e) {
      print(e);
    }
  }

  void setDate(DateTime tgl) {
    date.value = tgl;
    showDate(tgl);
    update();
  }

  void setDate2(DateTime tgl) {
    date2.value = tgl;
    showDate2(tgl);
    update();
  }

  void showDate(DateTime tgl) {
    dateShow.value = "${DateFormat("EEEE, dd MMMM yyyy", "id").format(tgl)}";
    update();
  }

  void showDate2(DateTime tgl) {
    dateShow2.value = "${DateFormat("EEEE, dd MMMM yyyy", "id").format(tgl)}";
    update();
  }

  getSingleTur() async {
    final ref = db.collection(table).withConverter(
        fromFirestore: Turnamen.fromFirestore,
        toFirestore: (Turnamen turnamen, _) => turnamen.toFirestore());
    try {
      dataSatuTur.clear();
      final docSnap = await ref.doc(turID.value).get();
      setDate(docSnap['date'].toDate());
      setDate2(docSnap['batas'].toDate());
      dataSatuTur.add(Turnamen(
        nama: docSnap['nama'],
        level: docSnap['level'],
        lokasi: docSnap['lokasi'],
        img: docSnap['img'],
        batas: docSnap['batas'].toDate(),
        date: docSnap['date'].toDate(),
        ket: docSnap['ket'],
        pbsi: docSnap['pbsi'],
        status: docSnap['status'],
        limit: docSnap['limit'],
        kontak: docSnap['kontak'],
        tipe: docSnap['tipe'],
      ));
      update();
    } catch (e) {
      print(e);
    }
  }

  daftarTur(String userID, String idPBSI) async {
    loadC.changeLoading(true);
    final ref = db.collection('peserta');
    try {
      await ref.add({
        "idUser" : userID,
        "idTurnamen" : turID.value, 
        "idPBSI" : idPBSI,
        "status" : "Pending"
      });
      terDaftar.value = true;
      update();
      loadC.changeLoading(false); 
      Get.snackbar("Berhasil", "Berhasil Mengajukan Pendaftaran",
            backgroundColor: Colors.green);
    } catch (e) {
      loadC.changeLoading(false);
      Get.snackbar("Gagal", "Gagal Mengajukan Pendaftaran",
          backgroundColor: Colors.red);
      print(e);
    }
  }

  cekTerdaftar(String userID) async {
    loadC.changeLoading(true);
    terDaftar.value = false;
    final ref = db.collection('peserta');
    try {
      final data = await ref
          .where('idUser'.toString(), isEqualTo: userID)
          .where('idTurnamen'.toString(), isEqualTo: turID.value)
          .get();
      if (data.docs.isNotEmpty) {
        terDaftar.value = true;
        update();
      }
      loadC.changeLoading(false);
    } catch (e) {
      loadC.changeLoading(false);
      print(e);
    }
  }
}
