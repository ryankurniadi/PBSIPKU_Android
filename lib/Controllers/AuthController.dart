import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import './LoadingController.dart';
import '../Routes/PageNames.dart';
import '../Controllers/SidebarContoller.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final _msg = FirebaseMessaging.instance;

  final loadC = Get.find<LoadingController>();
  final sideC = Get.find<SidebarController>();
  var isLogin = false.obs;
  var email = "".obs;
  var password = "".obs;
  var newpassword = "".obs;
  var newpassword2 = "".obs;
  var isLoginFail = false.obs;
  var isRegFail = false.obs;
  var pasGaksama = false.obs;
  var sandiSalah = false.obs;

  var authEmail = "".obs;
  var authLevel = "".obs;
  var authpbsi = "".obs;
  var authpbsinama = "".obs;
  var authimg = "".obs;
  var authUserID = "".obs;

  var authtoken = "".obs;
  var relog = false.obs;

  var devToken = "".obs;

  loginCheck() async {
    await initNotif();
    sideC.changeIndex(0);
    User? user = _auth.currentUser;
    if (user != null) {
      isLogin.value = true;
      authEmail.value = user.email!.toString();
      final datas = db.collection('users').where(
          'email'.toString().toLowerCase(),
          isEqualTo: authEmail.value.toLowerCase());
      final data = await datas.get();
      authLevel.value = data.docs[0]['level'];
      authpbsi.value = data.docs[0]['pbsi'];
      authimg.value = data.docs[0]['img'];
      authUserID.value = data.docs[0].id;

      final check = db.collection('users').doc(data.docs[0].id);
      if (data.docs[0]['token'] == "") {
        await check.update({
          "token": devToken.value,
        });
      } else if (data.docs[0]['token'] != devToken.value) {
        await check.update({
          "token": devToken.value,
        });
      }

      try {
        final datapb =
            await db.collection("pbsi").doc(data.docs[0]['pbsi']).get();
        if (datapb.data() != null) {
          authpbsinama.value = datapb.data()!['nama'];
          update();
        }
      } catch (e) {
        authpbsinama.value = data.docs[0]['pbsi'];
        print(e);
      }
      update();
    } else {
      isLogin.value = false;
      update();
    }
  }

  login() async {
    if (!relog.value) {
      sideC.changeIndex(0);
    }
    loadC.changeLoading(true);
    await initNotif();
    try {
      if (!email.value.contains('@')) {
        final rep = await db
            .collection('userlogs')
            .where('username', isEqualTo: email.value)
            .get();
        var data = rep.docs;
        if (data.isNotEmpty) {
          DocumentSnapshot document = data[0];
          email.value = document['email'];
        } else {
          isLoginFail.value = true;
          loadC.changeLoading(false);
          update();
          return null;
        }
      }
      final userCredential = await _auth.signInWithEmailAndPassword(
          email: email.value, password: password.value);
      final User? user = userCredential.user;

      if (user != null) {
        isLogin.value = true;
        authEmail.value = user.email!.toString();
        final data = await db
            .collection('users')
            .where('email'.toString().toLowerCase(),
                isEqualTo: authEmail.value.toLowerCase())
            .get();
        authLevel.value = data.docs[0]['level'];
        authpbsi.value = data.docs[0]['pbsi'];
        authimg.value = data.docs[0]['img'];
        authUserID.value = data.docs[0].id;
        try {
          final datapb =
              await db.collection("pbsi").doc(data.docs[0]['pbsi']).get();
          if (datapb.data() != null) {
            authpbsinama.value = datapb.data()!['nama'];
            update();
          }
        } catch (e) {
          authpbsinama.value = data.docs[0]['pbsi'];
          print(e);
        }
        final check = db.collection('users').doc(data.docs[0].id);
        if (data.docs[0]['token'] == "") {
          await check.update({
            "token": devToken.value,
          });
        } else if (data.docs[0]['token'] != devToken.value) {
          await check.update({
            "token": devToken.value,
          });
        }
        Get.offAllNamed(PageNames.Home);
      } else {
        isLoginFail.value = true;
      }
      loadC.changeLoading(false);
      update();
    } catch (e) {
      isLoginFail.value = true;
      loadC.changeLoading(false);
      update();
    }
  }

  logout() async {
    try {
      await _auth.signOut();
      isLogin.value = false;
      update();
      Get.offAllNamed(PageNames.Login);
    } catch (e) {
      print(e);
    }
  }

  Future<void> initNotif() async {
    final FCNToken = await _msg.getToken();
    if (FCNToken != null) {
      devToken.value = FCNToken;
    }
  }

  registerUser(String emailInput) async {
    isLoginFail.value = false;
    String password = "12345678";
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailInput,
        password: password,
      );
      await _auth.signOut();
      relog.value = true;
      login();
      relog.value = false;
    } catch (e) {
      isLoginFail.value = true;
      print('Error saat mendaftarkan pengguna: $e');
    }
  }

  checkEmail<bool>(String emailInput) async {
    try {
      final ref = await db
          .collection('users')
          .where('email'.toString().toLowerCase(),
              isEqualTo: emailInput.toLowerCase())
          .get();
      if (ref.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return null;
    }
  }

  changePassword() async {
    loadC.changeLoading(true);
    User? user = FirebaseAuth.instance.currentUser;
    try {
      final cred = EmailAuthProvider.credential(
          email: authEmail.value, password: password.value);
      await user?.reauthenticateWithCredential(cred);

      await user?.updatePassword(newpassword.value);
      Get.snackbar("Berhasil", "Kata Sandi Berhasil Diperbaharui",
          backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar("Gagal", "Kata sandi gagal di perbaharui",
          backgroundColor: Colors.red);
    }
    loadC.changeLoading(false);
  }

  @override
  void onInit() {
    loginCheck();
    super.onInit();
  }
}
