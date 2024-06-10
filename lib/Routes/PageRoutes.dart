import 'package:get/get.dart';

import './PageNames.dart';
import '../Middleware/AuthMiddleware.dart';
import '../Middleware/LoginMiddleware.dart';

import '../Bindings/HomeBinding.dart';
import '../Views/Pages/Home.dart';
import '../Views/Pages/Beranda.dart';
import '../Views/Pages/LoginPage.dart';
import '../Views/Pages/BlankPage.dart';
import '../Views/Pages/InitialPage.dart';

import '../Views/Pages/DataPBSI.dart';
import '../Views/Pages/AddPBSI.dart';
import '../Views/Pages/EditPBSI.dart';


import '../Views/Pages/AddTurnament.dart';
import '../Views/Pages/DataTurnamen.dart';

import '../Views/Pages/DataBerita.dart';


class PageRoutes {
  static final Pages = [
    GetPage(
      name: PageNames.Home, 
      binding: HomeBinding(),
      middlewares: [
        AuthMiddleware(),
      ],
      page: ()=>Home()),
    GetPage(
      name: PageNames.Blank, 
      middlewares: [
        AuthMiddleware(),
      ],
      page: ()=>const BlankPage()),
    GetPage(
      name: PageNames.Beranda, 
      middlewares: [
        AuthMiddleware(),
      ],
      page: ()=>Beranda()),
    GetPage(
      name: PageNames.Login, 
      middlewares: [
        LoginMiddleware()
      ],
      page: ()=>LoginPage()),
    GetPage(
      name: PageNames.Init, 
      page: ()=>Initialpage()),

    //PBSI
    GetPage(
      name: PageNames.DataPBSI, 
      middlewares: [
        AuthMiddleware(),
      ],
      page: ()=>DataPBSI()),
    GetPage(
      name: PageNames.AddPBSI, 
      middlewares: [
        AuthMiddleware(),
      ],
      page: ()=>AddPBSI()),
    GetPage(
      name: PageNames.EditPBSI, 
      middlewares: [
        AuthMiddleware(),
      ],
      page: ()=>EditPBSI()),

    //Turnamen
    GetPage(
      name: PageNames.DataTurnamen, 
      middlewares: [
        AuthMiddleware(),
      ],
      page: ()=>DataTurnamen()),
    GetPage(
      name: PageNames.AddTurnamen, 
      middlewares: [
        AuthMiddleware(),
      ],
      page: ()=>AddTurnamner()),

    //Berita 
    GetPage(
      name: PageNames.DataBerita, 
      middlewares: [
        AuthMiddleware(),
      ],
      page: ()=>DataBerita()),
  ];
}