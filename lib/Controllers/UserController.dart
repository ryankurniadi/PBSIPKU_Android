import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pbsipku/Models/PesertaView.dart';
import 'package:permission_handler/permission_handler.dart';

import '../Models/Peserta.dart';
import '../Models/User.dart';
import './AuthController.dart';
import './LoadingController.dart';

class UserController extends GetxController {
  final db = FirebaseFirestore.instance;
  final authC = Get.find<AuthController>();
  final loadC = Get.find<LoadingController>();
  String tabel = "users";

  File? image;
  var isImgPicked = false.obs;

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
  var userID2 = "".obs;

  var changeUsername = "".obs;

  var pbsiname = "".obs;

  var isRoot = true.obs;
  User? userProfil;


  var dataUserPBSI = [].obs;

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

  imgPicked(bool value) {
    isImgPicked.value = value;
    update();
  }

  pickImage() async {
    await Permission.photos.request();
    var status = await Permission.photos.status;

    if (status.isDenied) {
      print("gagal");
      return null;
    }

    final _image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (_image != null) {
      image = File(_image.path);
      imgPicked(true);
    }
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
      if (snap != null) {
        pbsiname.value = snap.data()!['nama'];
        //print(use.data()!['nama']);
      }

      update();
    } catch (e) {}
  }

  changeUser() async {
    loadC.changeLoading(true);
    final ref = db.collection("users").withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: (User user, _) => user.toFirestore());

    try {
      final data = await ref
          .where('username'.toString().toLowerCase(),
              isEqualTo: changeUsername.value.toLowerCase())
          .get();

      if (data.docs.length >= 1) {
        throw Exception("Udah ada");
      }

      final us = await db
          .collection('userlogs')
          .where('email'.toString().toLowerCase(),
              isEqualTo: authC.authEmail.value.toLowerCase())
          .get();
      String logID = us.docs[0].id;

      await ref.doc(authC.authUserID.value).update({
        "username": changeUsername.value,
      });
      await db.collection('userlogs').doc(logID).update({
        "username": changeUsername.value,
      });

      await getSingleUser();
      Get.snackbar("Berhasil", "Username Berhasil DiGanti",
          backgroundColor: Colors.green);
      update();
    } catch (e) {
      Get.snackbar("Gagal", "Gagal, Username Sudah Di Gunakan",
          backgroundColor: Colors.red);
    }

    loadC.changeLoading(false);
  }

  gantiProfil() async {
    loadC.changeLoading(true);
    final ref = db.collection("users").withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: (User user, _) => user.toFirestore());

    try {
      final data = await ref.doc(authC.authUserID.value).get();
      String? imgLink = data.data()!.img;

      Reference imgUpload = FirebaseStorage.instance
          .ref()
          .child('Users/')
          .child(DateTime.now().microsecondsSinceEpoch.toString() + ".png");
      UploadTask uploadTask = imgUpload.putFile(image!);

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      await ref.doc(authC.authUserID.value).update({
        "img": imageUrl,
      });

      if (imgLink != defaultimg) {
        Reference re = FirebaseStorage.instance.refFromURL(imgLink!);
        await re.delete();
      }

      await getSingleUser();
      update();
      Get.snackbar("Berhasil", "Profil berhasil diganti",
          backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar("Gagal", "Gagal, Mengganti Foto Profil",
          backgroundColor: Colors.red);
    }
    loadC.changeLoading(false);
  }

  getPBSIUser(String idPBSI)async {
    final ref = db.collection("users").withConverter(
        fromFirestore: User.fromFirestore,
        toFirestore: (User user, _) => user.toFirestore());

    try {
      final data = await ref.where('pbsi'.toString(), isEqualTo: authC.authpbsi.value)
      .where('email'.toString(),isNotEqualTo: authC.authEmail.value)
      .where('skill'.toString(), isEqualTo: authC.authSkill.value)
      .get();
      
      if(data.docs.isNotEmpty){
        dataUserPBSI.clear();
        for (var i = 0; i < data.docs.length; i++) {
          dataUserPBSI.add(
            User(
              id: data.docs[i].id,
              nama: data.docs[i]['nama'],
              hp: data.docs[i]['hp'],
              email: data.docs[i]['email'],
            ),
          );
          
        }
      }

    } catch (e) {
      print(e);
    }

    update();
  }

  @override
  void onInit() {
    getUserData();

    super.onInit();
  }
}
