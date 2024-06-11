import 'package:flutter/material.dart';

import '../Widgets/NavBar.dart';
import '../Widgets/Sidebar.dart';
class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: NavBar(title: "Blank Page"),
      //drawer: Sidebar(),
    ));
  }
}
