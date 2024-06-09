import 'package:get/get.dart';

import './PageNames.dart';

import '../Views/Pages/Home.dart';
import '../Views/Pages/LoginPage.dart';
import '../Views/Pages/BlankPage.dart';
import '../Views/Pages/DataPBSI.dart';
import '../Views/Pages/AddPBSI.dart';
import '../Views/Pages/EditPBSI.dart';
import '../Views/Pages/AddTurnament.dart';

import '../Views/Pages/DataTurnamen.dart';

class PageRoutes {
  static final Pages = [
    GetPage(
      name: PageNames.Home, 
      page: ()=>Home()),
    GetPage(
      name: PageNames.Blank, 
      page: ()=>const BlankPage()),
    GetPage(
      name: PageNames.Login, 
      page: ()=>const LoginPage()),

    //PBSI
    GetPage(
      name: PageNames.DataPBSI, 
      page: ()=>DataPBSI()),
    GetPage(
      name: PageNames.AddPBSI, 
      page: ()=>AddPBSI()),
    GetPage(
      name: PageNames.EditPBSI, 
      page: ()=>EditPBSI()),

    //Turnamen
    GetPage(
      name: PageNames.DataTurnamen, 
      page: ()=>DataTurnamen()),
    GetPage(
      name: PageNames.AddTurnamen, 
      page: ()=>AddTurnamner()),
      
  ];
}