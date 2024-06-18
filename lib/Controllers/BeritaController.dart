import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/Berita.dart';
import './LoadingController.dart';
import './AuthController.dart';

class BeritaController extends GetxController {
  final db = FirebaseFirestore.instance;
  final authC = Get.find<AuthController>();
  final loadC = Get.find<LoadingController>();
  final Rx<Uint8List?> imageBytes = Uint8List(0).obs;
  var id = "".obs;
  var img = "".obs;
  var totalBerita = 0.obs;
  String table = 'berita';
  var dataBeritaAdmin = [].obs;
  var totalBeritaAdmin = 0.obs;

  var dataSingle = [].obs;

  getData() async {
    final ref = db.collection(table).withConverter(
        fromFirestore: Berita.fromFirestore,
        toFirestore: (Berita berita, _) => berita.toFirestore());

    try {
      var data = await ref.orderBy('date', descending: true).limit(7).get();
      if (authC.authpbsi.value != "") {
        data = await ref
            .where('penulis'.toString(),
                whereIn: ['${authC.authpbsi.value}', 'PBSI Pusat'])
            .orderBy('date', descending: true)
            .limit(7)
            .get();
      }
      if (data.docs.isNotEmpty) {
        totalBeritaAdmin.value = data.docs.length;
        dataBeritaAdmin.clear();
        for (var i = 0; i < totalBeritaAdmin.value; i++) {
          String? author = data.docs[i].data().penulis;
          if (data.docs[i].data().penulis == "") {
            author = "PBSI Pusat";
          } else {
            if (author != "PBSI Pusat") {
              final dataPBSI = await db.collection('pbsi').doc(author).get();
              if (dataPBSI != null) {
                author = "${dataPBSI.data()!['nama']}";
              }
            }
          }

          dataBeritaAdmin.add(Berita(
            judul: data.docs[i].data().judul,
            date: data.docs[i].data().date,
            id: data.docs[i].data().id,
            img: data.docs[i].data().img,
            isi: data.docs[i].data().isi,
            penulis: author,
          ));
        }
      } else {
        totalBeritaAdmin.value = 0;
      }
      update();
    } catch (e) {
      print(e);
    }
  }

  getSingleBerita(String id) async {
    final ref = db.collection(table).withConverter(
        fromFirestore: Berita.fromFirestore,
        toFirestore: (Berita berita, _) => berita.toFirestore());

    try {
      final data = await ref.doc(id).get();
      if (data.data() == null) {
        throw Exception("Data Kosong");
      }
      Berita dataModel = data.data()!;
      String? penulis = dataModel.penulis;
      if (penulis! != 'PBSI Pusat') {
        final dataPBSI =
            await db.collection('pbsi').doc(data.data()!.penulis).get();
        if (dataPBSI.data() == null) {
          throw Exception("Data Kosong");
        }
        penulis = dataPBSI.data()!['nama'];
      }
      dataSingle.clear();
      dataSingle.add(Berita(
          id: dataModel.id,
          judul: dataModel.judul,
          penulis: penulis,
          date: dataModel.date,
          img: dataModel.img,
          isi: dataModel.isi));

      update();
    } catch (e) {
      print(e);
    }
  }
}
