import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/PBSI.dart';
import '../Models/User.dart';
import './AuthController.dart';
import './LoadingController.dart';

class UserController extends GetxController {
  final db = FirebaseFirestore.instance;
  final authC = Get.find<AuthController>();
  final loadC = Get.find<LoadingController>();
  String tabel = "users";

  var dataUser = [].obs;
  var totalUser = 0.obs;

  //data imputan
  var defaultimg =
      "https://firebasestorage.googleapis.com/v0/b/pbsi-pku.appspot.com/o/Users%2Fdefault.png?alt=media&token=640e9911-8829-4370-9a0c-227496d07284";
  var nama = "".obs;
  var level = "".obs;
  var username = "".obs;
  var email = "".obs;
  var isActive = false.obs;
  var isPickUsername = false.obs;
  var pbsi = "".obs;
  var skill = "Level D".obs;
  var hp = 0.obs;

  var pbsiname = "".obs;

  var isRoot = true.obs;
  User? userProfil;

  getUserData() async {
    final ref = db.collection("users").withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: (User user, _) => user.toFirestore());
    try {
      final docSnap = await ref.orderBy('nama').get();
      if (docSnap.docs.isNotEmpty) {
        totalUser.value = docSnap.docs.length;
        dataUser.clear();
        for (var i = 0; i < docSnap.docs.length; i++) {
          dataUser.add(User(
            id: docSnap.docs[i].id,
            nama: docSnap.docs[i].data().nama,
            hp: docSnap.docs[i].data().hp,
            email: docSnap.docs[i].data().email,
            img: docSnap.docs[i].data().img,
            isActive: docSnap.docs[i].data().isActive,
            isPickUsername: docSnap.docs[i].data().isPickUsername,
            username: docSnap.docs[i].data().username,
            level: docSnap.docs[i].data().level,
            pbsi: docSnap.docs[i].data().pbsi,
            skill: docSnap.docs[i].data().skill,
          ));
        }
      } else {
        totalUser.value = 0;
        dataUser.clear();
      }
      update();
    } catch (e) {}
  }


  levelUserChanger(bool value) {
    isRoot.value = value;
    update();
  }

  getSingleUser() async {
    try {
      final ref = db.collection("users").withConverter(
            fromFirestore: User.fromFirestore,
            toFirestore: (User user, _) => user.toFirestore());
      final data = await ref
          .where('email'.toString().toLowerCase(),
              isEqualTo: authC.authEmail.value.toLowerCase())
          .get();
      userProfil = User(
        id: ref.id,
        nama: data.docs[0]['nama'],
        level: data.docs[0]['level'],
        username: data.docs[0]['username'],
        email: data.docs[0]['email'],
        hp: data.docs[0]['hp'],
        img: data.docs[0]['img'],
        isActive: data.docs[0]['isActive'],
        isPickUsername: data.docs[0]['isPickUsername'],
        pbsi: data.docs[0]['pbsi'],
        skill: data.docs[0]['skill'],
        token: data.docs[0]['token'],
      );


      final snap = await db.collection('pbsi').doc(userProfil!.pbsi).get();
        if(snap != null){
          pbsiname.value = snap.data()!['nama'];
          //print(use.data()!['nama']);
        }

      update();
    } catch (e) {}
  }

  @override
  void onInit() {
    getUserData();
   
    super.onInit();
  }
}
