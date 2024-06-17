import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pbsipku/firebase_options.dart';

import './Api/Firebase_notif.dart';
import './Routes/PageRoutes.dart';
import './Views/Pages/InitialPage.dart';
import './Bindings/HomeBinding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'id'; 
  initializeDateFormatting('id');
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseNotif().initNotif();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: HomeBinding(),
      home: Initialpage(),
      transitionDuration: Duration.zero,
      defaultTransition: Transition.noTransition,
      getPages: PageRoutes.Pages,
    );
  }
}
