import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Models/Turnamen.dart';
import '../Models/Peserta.dart';
import '../Models/PesertaView.dart';
import '../Models/User.dart';
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

  var userID2 = "".obs;
  var turID = "".obs;
  var dataSatuTur = [].obs;
  var isEditImg = false.obs;
  var terDaftar = false.obs;

  var riwayatTur = [].obs;
  var riwayatTur1 = [].obs;
  var riwayatTur2 = [].obs;

  var totalRiwayat = 0.obs;

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
          .where('tipe'.toString(),
              whereIn: ['Publik', "${userC.authC.authpbsi.value}"])
          .where('status'.toString(), isEqualTo: 'Disetujui')
          .orderBy('date', descending: true)
          .get();
      if (docSnap.docs.isNotEmpty) {
        dataTurnamen.clear();
        totalTur.value = docSnap.docs.length;
        for (var i = 0; i < docSnap.docs.length; i++) {
          if (docSnap.docs[i]
              .data()
              .batas!
              .isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
            dataTurnamen.add(Turnamen(
              id: docSnap.docs[i].id,
              nama: docSnap.docs[i].data().nama,
              img: docSnap.docs[i].data().img,
              biaya: docSnap.docs[i].data().biaya,
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
        biaya: docSnap['biaya'],
        kontak: docSnap['kontak'],
        tipe: docSnap['tipe'],
      ));
      update();
    } catch (e) {
      print(e);
    }
  }

  daftarTur(String userID, String userID2, String idPBSI) async {
    loadC.changeLoading(true);
    final ref = db.collection('peserta');
    try {
      await ref.add({
        "idUser": userID,
        "idUser2": userID2,
        "idTurnamen": turID.value,
        "idPBSI": idPBSI,
        "status": "Pending",
        "pembayaran": "Belum Lunas",
        "createdAt": DateTime.now(),
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
      if (terDaftar.value == false) {
        final data = await ref
            .where('idUser2'.toString(), isEqualTo: userID)
            .where('idTurnamen'.toString(), isEqualTo: turID.value)
            .get();
        if (data.docs.isNotEmpty) {
          terDaftar.value = true;
          update();
        }
      }

      loadC.changeLoading(false);
    } catch (e) {
      loadC.changeLoading(false);
      print(e);
    }
  }

  getUserTur(String idUser) async {
    final ref = db.collection("peserta").withConverter(
        fromFirestore: Peserta.fromFirestore,
        toFirestore: (Peserta peserta, _) => peserta.toFirestore());

    try {
      final dataPeserta =
          await ref.where('idUser'.toString(), isEqualTo: idUser).get();
      riwayatTur1.clear();
      if (dataPeserta.docs.isNotEmpty) {
        
        for (var i = 0; i < dataPeserta.docs.length; i++) {
          final refa = db.collection(table).withConverter(
              fromFirestore: Turnamen.fromFirestore,
              toFirestore: (Turnamen turnamen, _) => turnamen.toFirestore());
          final dataTur =
              await refa.doc(dataPeserta.docs[i].data().idTurnamen).get();
          final refUser = db.collection("users").withConverter(
              fromFirestore: User.fromFirestore,
              toFirestore: (User user, _) => user.toFirestore());

          final dataUser2 =
              await refUser.doc(dataPeserta.docs[i].data().idUser2).get();

          riwayatTur1.add(Pesertaview(
            id: dataPeserta.docs[i].data().id,
            idPBSI: dataPeserta.docs[i].data().idPBSI,
            idTurnamen: dataPeserta.docs[i].data().idTurnamen,
            idUser: dataPeserta.docs[i].data().idUser,
            namaTur: dataTur.data()!.nama,
            tipe: dataTur.data()!.tipe,
            nama2: dataUser2.data()!.nama!,
            batas: dataTur.data()!.batas,
            date: dataTur.data()!.date,
            img: dataTur.data()!.img,
            level: dataTur.data()!.level,
            lokasi: dataTur.data()!.lokasi,
            biaya: dataTur.data()!.biaya,
            pembayaran: dataPeserta.docs[i].data().pembayaran,
            status: dataPeserta.docs[i].data().status,
          ));

          //DATA 2
        }
      }
      riwayatTur2.clear();
      final dataPeserta2 =
          await ref.where('idUser2'.toString(), isEqualTo: idUser).get();
      if (dataPeserta2.docs.isNotEmpty) {
        
        for (var i = 0; i < dataPeserta2.docs.length; i++) {
          final refa = db.collection(table).withConverter(
              fromFirestore: Turnamen.fromFirestore,
              toFirestore: (Turnamen turnamen, _) => turnamen.toFirestore());
          final dataTur =
              await refa.doc(dataPeserta2.docs[i].data().idTurnamen).get();
          final refUser = db.collection("users").withConverter(
              fromFirestore: User.fromFirestore,
              toFirestore: (User user, _) => user.toFirestore());

          final dataUser2 =
              await refUser.doc(dataPeserta2.docs[i].data().idUser).get();
          riwayatTur2.add(Pesertaview(
            id: dataPeserta2.docs[i].data().id,
            idPBSI: dataPeserta2.docs[i].data().idPBSI,
            idTurnamen: dataPeserta2.docs[i].data().idTurnamen,
            idUser: dataPeserta2.docs[i].data().idUser,
            namaTur: dataTur.data()!.nama,
            tipe: dataTur.data()!.tipe,
            batas: dataTur.data()!.batas,
            nama2: dataUser2.data()!.nama!,
            date: dataTur.data()!.date,
            img: dataTur.data()!.img,
            level: dataTur.data()!.level,
            lokasi: dataTur.data()!.lokasi,
            biaya: dataTur.data()!.biaya,
            pembayaran: dataPeserta2.docs[i].data().pembayaran,
            status: dataPeserta2.docs[i].data().status,
          ));
        }
      }
      riwayatTur.clear();
      riwayatTur.value = [...riwayatTur1, ...riwayatTur2];
      riwayatTur.sort((a, b) => b.date.compareTo(a.date));
      totalRiwayat.value = riwayatTur.length;
      update();
    } catch (e) {
      print(e);
    }
  }
}
