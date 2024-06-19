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
import '../Views/Pages/DetailTurnamen.dart';
import '../Views/Pages/BeritaFull.dart';
import '../Views/Pages/Settings.dart';



import '../Views/Pages/Profil.dart';

class PageRoutes {
  static final Pages = [
    GetPage(
        name: PageNames.Home,
        binding: HomeBinding(),
        middlewares: [
          AuthMiddleware(),
        ],
        page: () => Home()),
    GetPage(
        name: PageNames.Blank,
        middlewares: [
          AuthMiddleware(),
        ],
        page: () => const BlankPage()),
    GetPage(
        name: PageNames.Beranda,
        middlewares: [
          AuthMiddleware(),
        ],
        page: () => Beranda()),
    GetPage(
        name: PageNames.Settings,
        middlewares: [
          AuthMiddleware(),
        ],
        page: () => Settings()),
    GetPage(
        name: PageNames.Login,
        middlewares: [LoginMiddleware()],
        page: () => LoginPage()),
    GetPage(
        name: PageNames.Init,
        binding: HomeBinding(),
        page: () => Initialpage()),


    //Profil
        GetPage(
        name: PageNames.Profil,
        middlewares: [
          AuthMiddleware(),
        ],
        page: () => Profil()),
        
        GetPage(
        name: PageNames.DetailTurnamen,
        middlewares: [
          AuthMiddleware(),
        ],
        page: () => DetailTurnamen()),

        GetPage(
        name: PageNames.DetailBerita,
        middlewares: [
          AuthMiddleware(),
        ],
        page: () => Beritafull()),

  ];
}
