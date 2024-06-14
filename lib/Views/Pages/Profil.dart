import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

import '../Widgets/NavBar.dart';
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
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SmartRefresher(
          controller: _refreshController,
          onLoading: ()async{
            print("load");
            await userC.getSingleUser();
             _refreshController.loadComplete();
          },
          onRefresh: ()async{
             _refreshController.refreshCompleted();
          },
          child: GetBuilder<UserController>(
            builder: (userC) => ListView(
              //padding: EdgeInsets.symmetric(horizontal: Get.width/3, vertical: 20),
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage("${userC.userProfil!.img}"),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                    child: Text(
                  "${userC.userProfil!.nama}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                const SizedBox(
                  height: 5,
                ),
                Center(
                    child: Text(
                  "${userC.userProfil!.level}",
                  style: const TextStyle(
                    fontSize: 15,
                    //fontWeight: FontWeight.bold,
                  ),
                )),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Nama PBSI",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('${userC.pbsiname}')
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Username",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            (userC.userProfil!.isPickUsername == true
                                ? Text('${userC.userProfil!.username}')
                                : Row(
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {},
                                          child: Text("Ganti Username")),
                                      Text('${userC.userProfil!.username}'),
                                    ],
                                  ))
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "E-mail",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('${userC.userProfil!.email}')
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "No HP",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('${userC.userProfil!.hp}')
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Level Permain",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('${userC.userProfil!.skill}')
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("PERBAHARUI PROFIL"),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    authC.logout();
                  },
                  child: const Text("Log Out"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
