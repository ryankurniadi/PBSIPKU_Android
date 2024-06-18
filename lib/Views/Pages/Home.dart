import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Pages/BlankPage.dart';
import '../Pages/Profil.dart';
import '../Pages/Riwayat.dart';
import '../Pages/DataBerita.dart';
import '../Pages/DataTurnamen.dart';
import '../../Controllers/PBSIController.dart';
import '../../Controllers/UserController.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final pbsiC = Get.put(PBSIController());
  final userC = Get.find<UserController>();

  var _index = 0.obs;

  static final List<Widget> _widgetOptions = [
    DataBerita(),
    DataTrunamen(),
    Riwayat(),
    Profil(),
  ];

  @override
  void initState() {
    userC.getSingleUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

          bottomNavigationBar: Obx(() => AnimatedBottomNavigationBar.builder(
                itemCount: 4,
                activeIndex: _index.value,
                onTap: (index) {
                  _index.value = index;
                },
                height: 65,
                gapLocation: GapLocation.none,
                backgroundColor: const Color.fromARGB(255, 32, 21, 34),
                
                tabBuilder: (index, isActive) {
                  switch (index) {
                    case 0:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.house, color: (isActive ? Colors.amber: Colors.white)),
                          Text("Home", style: TextStyle(
                            color: (isActive ? Colors.amber: Colors.white)
                          )),
                        ],
                      );
                    case 1:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.trophy, color: (isActive ? Colors.amber: Colors.white)),
                          Text("Turnamen", style: TextStyle(
                            color: (isActive ? Colors.amber: Colors.white)
                          )),
                        ],
                      );
                    case 2:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.solidClipboard, color: (isActive ? Colors.amber: Colors.white)),
                          Text("Riwayat", style: TextStyle(
                            color: (isActive ? Colors.amber: Colors.white)
                          )),
                        ],
                      );
                    case 3:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.solidUser, color: (isActive ? Colors.amber: Colors.white)),
                          Text("Profil", style: TextStyle(
                            color: (isActive ? Colors.amber: Colors.white)
                          )),
                        ],
                      );
                    default:
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(FontAwesomeIcons.house, color: (isActive ? Colors.amber: Colors.white)),
                          Text("Home", style: TextStyle(
                            color: (isActive ? Colors.amber: Colors.white)
                          )),
                        ],
                      );
                  }
                },
              )),
          body: Obx(
            () => SizedBox(
              child: _widgetOptions.elementAt(_index.value),
            ),
          )),
    );
  }
}
