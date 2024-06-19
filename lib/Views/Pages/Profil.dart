import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker_android/image_picker_android.dart';

import '../Widgets/LoadingBarrier.dart';
import '../../Routes/PageNames.dart';
import '../../Controllers/UserController.dart';
import '../../Controllers/AuthController.dart';

class Profil extends StatefulWidget {
  Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  final authC = Get.find<AuthController>();
  final userC = Get.find<UserController>();
  final _formKey = GlobalKey<FormState>();
  final _refreshController = RefreshController(initialRefresh: false);

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed(PageNames.Settings);
                },
                icon: const FaIcon(FontAwesomeIcons.ellipsisVertical))
          ],
        ),
        body: LoadingBarrier(
          child: GetBuilder<UserController>(
            builder: (userC) => ListView(
              padding: const EdgeInsets.only(top: 0),
              //padding: EdgeInsets.symmetric(horizontal: Get.width/3, vertical: 20),
              children: [
                SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: Get.width / 5,
                        right: Get.width / 5,
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(50)),
                          child: Center(
                            child: Text(
                              "${userC.userProfil!.skill}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 130,
                        left: 0,
                        right: 0,
                        child: Center(
                          //height: 140,
                          child: Stack(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                maxRadius: 67,
                                backgroundImage:
                                    NetworkImage("${userC.userProfil!.img}"),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: FloatingActionButton(
                                  shape: const CircleBorder(),
                                  backgroundColor: Colors.white70,
                                  mini: true,
                                  onPressed: () {
                                    userC.imgPicked(false);
                                    Get.defaultDialog(
                                      title: "Pilih Gambar",
                                      content: GetBuilder<UserController>(
                                        builder: (userC) {
                                          if (!userC.isImgPicked.value) {
                                            return Center(
                                              child: InkWell(
                                                onTap: () async{
                                                  userC.pickImage();
                                                },
                                                child: Container(
                                                  height: 250,
                                                  width: 250,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons.camera_alt,
                                                    size: 100,
                                                    color: Colors.black38,
                                                  )),
                                                ),
                                              ),
                                            );
                                          }
                                          return Column(
                                            children: [
                                              Container(
                                                height: 250,
                                                width: 250,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: Image.file(userC.image!)),
                                              ),
                                              const SizedBox(height: 10,),
                                              TextButton(onPressed: ()async{
                                                Get.back();
                                                await userC.gantiProfil();
                                              },style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green), padding: WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 20))), child: const Text("Ganti Foto Profil", style: TextStyle(color: Colors.white),))
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.camera_alt,
                                    size: 24,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 80,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Text(
                              "${userC.userProfil!.nama}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.white),
                            ),
                            Text(
                              "${userC.userProfil!.email}",
                              style: const TextStyle(
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: ,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      ListTile(
                        title: const Text(
                          "Username",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: (userC.userProfil!.username != "null"
                            ? Text('${userC.userProfil!.username}')
                            : InkWell(
                                onTap: () {
                                  Get.defaultDialog(
                                    title: "Buat Username",
                                    barrierDismissible: false,
                                    confirm: TextButton(
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          Get.back();
                                          userC.changeUser();
                                        }
                                      },
                                      style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.green),
                                      ),
                                      child: const Text(
                                        "Buat Username",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    cancel: TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: const Text("Batal")),
                                    content: Form(
                                        key: _formKey,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "Masukan Username"),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "Data tidak Boleh Kosong";
                                                  }
                                                  if (value.length <= 5) {
                                                    return "Minimal 6 Digit karakter";
                                                  }
                                                },
                                                onSaved: (value) {
                                                  userC.changeUsername.value =
                                                      value!;
                                                },
                                              )
                                            ],
                                          ),
                                        )),
                                  );
                                },
                                child: const Text(
                                  "Buat Username",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        leading: const FaIcon(FontAwesomeIcons.solidUser),
                      ),
                      ListTile(
                        title: const Text(
                          "Asal PBSI",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        leading: const FaIcon(FontAwesomeIcons.baseball),
                        subtitle: Text(authC.authpbsinama.value),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            authC.logout();
                          },
                          child: Text("Log out"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
