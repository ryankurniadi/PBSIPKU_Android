import 'package:firebase_messaging/firebase_messaging.dart';


class FirebaseNotif{
  final _msg = FirebaseMessaging.instance;

  Future<void> initNotif() async{
    await _msg.requestPermission();
    
  }
}

Future<void> handleBackground(RemoteMessage msg)async{
 print(msg.data); 
}