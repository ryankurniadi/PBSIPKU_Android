import 'package:flutter/material.dart';

import '../Pages/Beranda.dart';
import '../Pages/BlankPage.dart';
import '../Pages/DataPBSI.dart';
import '../Pages/DataTurnamen.dart';
import '../Pages/DataBerita.dart';
import '../Pages/DataUsers.dart';

class NewSideBar extends StatelessWidget {
  NewSideBar({super.key, required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return Beranda();
      case 1:
        return DataPBSI();
      case 2:
        return DataTurnamen();
      case 3:
        return DataBerita();
      case 4:
        return DataUsers();
      case 5:
        return const BlankPage();
      default: 
        return Beranda();
    }
  }
}