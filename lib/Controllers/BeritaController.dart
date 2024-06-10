import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/Berita.dart';

class BeritaController extends GetxController{
  final db = FirebaseFirestore.instance;
  final Rx<Uint8List?> imageBytes = Uint8List(0).obs;
  var id = "".obs;
  var img = "".obs;
  var totalBerita = 0.obs;
  
  

}