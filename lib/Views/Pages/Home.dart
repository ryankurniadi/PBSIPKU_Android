import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Pages/BlankPage.dart';
import '../Pages/Profil.dart';
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

  static List<Widget> _widgetOptions = <Widget>[
    const BlankPage(),
    DataTrunamen(),
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
            appBar: AppBar(
              title: const Text("PBSI PEKANBARU"),
            ),
            body: Obx(
              () => SizedBox(
                child: _widgetOptions.elementAt(_index.value),
              ),
            ),
            bottomNavigationBar: Obx(
              () {
                return BottomNavigationBar(
                  currentIndex: _index.value,
                  onTap: (value) {
                    _index.value = value;
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.sports),
                      label: 'Turnamen',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person),
                      label: 'Profil',
                    ),
                  ],
                );
              },
            )));
  }
}
