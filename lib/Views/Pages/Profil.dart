import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(onPressed: (){
              Get.toNamed(PageNames.Settings);
            }, icon: const FaIcon(FontAwesomeIcons.ellipsisVertical))
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          onLoading: () async {
            print("load");
            await userC.getSingleUser();
            _refreshController.loadComplete();
          },
          onRefresh: () async {
            _refreshController.refreshCompleted();
          },
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
                        child: Container(
                          height: 150,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            child: Image.network(
                              "${userC.userProfil!.img}",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 90,
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
                        title: Text("Username"),
                        subtitle: Text('${userC.userProfil!.username}'),
                        leading: FaIcon(FontAwesomeIcons.solidUser),
                      ), 
                      ListTile(
                        title: Text("Asal PBSI"),
                        leading: FaIcon(FontAwesomeIcons.baseball),
                        subtitle: Text('${authC.authpbsinama.value}'),
                      ), 
                      const SizedBox(height: 5,),
                      ElevatedButton(onPressed: (){
                        authC.logout();
                      }, child: Text("Log out"))
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
