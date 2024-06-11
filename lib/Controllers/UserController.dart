import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/User.dart';
import 'AuthController.dart';

class UserController extends GetxController {
  final db = FirebaseFirestore.instance;
  final authC = Get.find<AuthController>();
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
  var skill = "".obs;
  var hp = 0.obs;

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

  addUser() async {
    final _user = User(
      nama: nama.value,
      img: defaultimg,
      username: "null",
      email: email.value,
      hp: hp.value,
      isActive: isActive.value,
      isPickUsername: isPickUsername.value,
      level: level.value,
      pbsi: pbsi.value,
      skill: skill.value,
    );
    try {
      if (await authC.checkEmail(email.value)) {
        throw Exception();
      } else {
        await authC.registerUser(email.value);
        final ref = db.collection("users").withConverter(
            fromFirestore: User.fromFirestore,
            toFirestore: (User user, _) => user.toFirestore());
        await ref.add(_user);
        getUserData();
        Get.back();
        Get.snackbar("Berhasil", "Data Berhasil Di tambah",
            backgroundColor: Colors.green);
      }
    } catch (e) {
      Get.snackbar("Gagal", "Data Gagal Di Tambah",
          backgroundColor: Colors.red);
    }
  }

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
}
