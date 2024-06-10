import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Routes/PageNames.dart';
import '../../Controllers/AuthController.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("LOGIN PBSI PEKANBARU"),
            SizedBox(
              height: 20,
            ),
            GetBuilder<AuthController>(builder: (authC) {
              return Form(
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: Get.width / 3),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 40),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Username/E-mail",
                                prefixIcon: Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Melengkungkan border
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Icons.lock),
                                filled: true,
                                fillColor: Colors.grey[200],
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Melengkungkan border
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: Get.width / 3,
                      height: 60,
                      child: ElevatedButton(
                          style: ButtonStyle(),
                          onPressed: () {
                            authC.loginCheck();
                            if (authC.isLogin.value) {
                              Get.offAllNamed(PageNames.Home);
                            }
                          },
                          child: Text("LOGIN")),
                    )
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    ));
  }
}
