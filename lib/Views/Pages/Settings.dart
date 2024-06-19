import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Widgets/LoadingBarrier.dart';
import '../../Controllers/AuthController.dart';
import '../../Controllers/UserController.dart';

class Settings extends StatelessWidget {
  Settings({super.key});
  final authC = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan Akun"),
        elevation: 1,
      ),
      body: LoadingBarrier(
        child: ListView(
          children: [
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.lock,
                size: 20,
              ),
              title: const Text('Perbaharui Kata Sandi'),
              trailing: const FaIcon(FontAwesomeIcons.angleRight),
              onTap: () {
                Get.defaultDialog(
                    title: "Perbaharui Kata Sandi",
                    barrierDismissible: false,
                    content: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: 'Kata Sandi Lama'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Wajib diisi";
                                  }
                                  if (value.length < 7) {
                                    return "Panjang minimal 8 digit";
                                  }
                                },
                                onSaved: (value) {
                                  authC.password.value = value!;
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: 'Kata Sandi Baru'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Wajib diisi";
                                  }
                                  if (value.length < 7) {
                                    return "Panjang minimal 8 digit";
                                  }
                                },
                                onChanged: (value) {
                                  authC.newpassword.value = value;
                                },
                                onSaved: (value) {
                                  authC.newpassword.value = value!;
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                obscureText: true,
                                decoration: const InputDecoration(
                                    hintText: 'Ulangi Kata Sandi Baru'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Wajib diisi";
                                  }
                                  if (value.length < 7) {
                                    return "Panjang minimal 8 digit";
                                  }
                                },
                                onChanged: (value) {
                                  authC.newpassword2.value = value;
                                  if (authC.newpassword2.value !=
                                      authC.newpassword.value) {
                                    authC.pasGaksama.value = true;
                                  } else {
                                    authC.pasGaksama.value = false;
                                  }
                                },
                                onSaved: (value) {
                                  authC.newpassword.value = value!;
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Obx(() => (authC.pasGaksama.value
                                  ? const Text("Kata sandi baru tidak sama", style: TextStyle(color: Colors.red),)
                                  : const SizedBox())),
                              Obx(() => (authC.sandiSalah.value
                                  ? const Text("Kata sandi lama anda salah", style: TextStyle(color: Colors.red),)
                                  : const SizedBox())),
                            ],
                          ),
                        )),
                    cancel: TextButton(
                        onPressed: () => Get.back(), child: const Text("Batal")),
                    confirm: TextButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(Colors.green),
                        ),
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                            if(!authC.pasGaksama.value){
                              _formKey.currentState!.save();
                              Get.back();
                              
                              authC.changePassword();
                              
                              
                            }
                          }
                          ;
                        },
                        child: const Text(
                          "Perbaharui",
                          style: TextStyle(color: Colors.white),
                        )));
              },
            ),
            Divider(color: Colors.grey.shade300),
            const ListTile(
              leading: FaIcon(
                FontAwesomeIcons.user,
                size: 20,
              ),
              title: Text('Perbaharui data pribadi'),
              trailing: FaIcon(FontAwesomeIcons.angleRight),
            ),
            Divider(color: Colors.grey.shade300),
          ],
        ),
      ),
    ));
  }
}
