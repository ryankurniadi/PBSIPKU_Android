import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './LoadingController.dart';
import '../Routes/PageNames.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final loadC = Get.find<LoadingController>();
  var isLogin = false.obs;
  var email = "".obs;
  var password = "".obs;
  var isLoginFail = false.obs;

  var authEmail = "".obs;

  loginCheck() {
    User? user = _auth.currentUser;
    if (user != null) {
      authEmail.value = user.email!;
      isLogin.value = true;
    } else {
      isLogin.value = false;
    }
    update();
  }

  login() async {
    loadC.changeLoading(true);
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
        authEmail.value = user.email!;
        Get.offAllNamed(PageNames.Home);
      } else {
        isLoginFail.value = true;
      }
      loadC.changeLoading(false);
      update();
    } catch (e) {
      print(e);
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

  registerUser(String emailInput) async {
    String password = "12345678";
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailInput,
        password: password,
      );
    } catch (e) {
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

  @override
  void onInit() {
    loginCheck();
    super.onInit();
  }
}
