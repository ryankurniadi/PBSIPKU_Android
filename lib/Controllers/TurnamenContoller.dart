import 'dart:html';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../Models/Turnamen.dart';
import './LoadingController.dart';


class TurnamenController extends GetxController {
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
  var totalTur = 0.obs;
  var dataTurnamen = [].obs;
  var date = DateTime.now().obs;
  var date2 = DateTime.now().obs;
  var dateShow = "".obs;
  var dateShow2 = "".obs;
  var statusupload = true.obs;

  final loadC = Get.find<LoadingController>();

  @override
  void onInit() {
    getData();
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
            batas: docSnap.docs[i].data().batas,
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

  void addData(Uint8List image) async {
    statusupload.value = true;
    final ref = db.collection(table).withConverter(
        fromFirestore: Turnamen.fromFirestore,
        toFirestore: (Turnamen turnamen, _) => turnamen.toFirestore());
    try {
      await uploadImg(image);
      if (!statusupload.value) {
        throw Exception('No Image');
      }
      await ref.add(
        Turnamen(
          nama: nama.value,
          date: date.value,
          status: "Publish",
          ket: ket.value,
          level: level.value,
          img: link.value,
          batas: date2.value,
        ),
      );
      loadC.changeLoading(false);
      Get.back();
      Get.snackbar("Berhasil", "Data Berhasil Di tambah",
          backgroundColor: Colors.green);
      await getData();
      imageBytes.value = Uint8List(0);
    } catch (e) {
      loadC.changeLoading(false);
      Get.snackbar("Gagal", "Data Gagal Di Tambah",
          backgroundColor: Colors.red);
    }
    
  }

  void deleteData(String id, String img) async {
    try {
      Reference ref = FirebaseStorage.instance.refFromURL(img);
      await db.collection(table).doc(id).delete();
      await ref.delete();
      Get.back();
      Get.snackbar("Berhasil", "Data Berhasil Di Hapus",
          backgroundColor: Colors.green);
      getData();
    } catch (e) {
      Get.snackbar("Gagal", "Data Gagal Di Hapus", backgroundColor: Colors.red);
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

  uploadImg(Uint8List imageData) async {
    try {
      if (imageBytes.value != null && imageBytes.value!.isNotEmpty) {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('/Turnamen')
            .child(DateTime.now().microsecondsSinceEpoch.toString() + ".png");
        await ref.putData(imageData);
        String downloadURL = await ref.getDownloadURL();
        link.value = downloadURL;
      } else {
        statusupload.value = false;
        throw Exception('No Image');
      }
    } catch (e) {
      Get.snackbar("Gagal", "Gambar Gagal Di Upload",
          backgroundColor: Colors.red);
    }
  }

  Future<void> pickImage() async {
    final FileUploadInputElement input = FileUploadInputElement();
    input..accept = 'image/*';
    input.click();
    input.onChange.listen((e) {
      final File file = input.files!.first;
      final FileReader reader = FileReader();

      reader.onLoadEnd.listen((e) {
        imageBytes.value = reader.result as Uint8List?;
      });

      reader.readAsArrayBuffer(file);
    });
    update();
  }
}
