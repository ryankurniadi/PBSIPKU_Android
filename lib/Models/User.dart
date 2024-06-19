import 'package:cloud_firestore/cloud_firestore.dart';

class User{
  String? id;
  String? nama;
  String? level;
  String? username;
  String? email;
  bool? isActive;
  bool? isPickUsername;
  String? pbsi;
  String? skill;
  String? img;
  String? token;
  int? hp;
  int? nik;

  User({
    this.id,
    this.nama,
    this.level,
    this.token,
    this.img,
    this.email,
    this.hp,
    this.nik,
    this.pbsi,
    this.skill,
    this.isActive,
    this.isPickUsername,
    this.username,
  });

  factory User.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ){
    final data = snapshot.data();
    return User(
      id: snapshot.id,
      nama: data?['nama'],
      email: data?['email'],
      hp: data?['hp'],
      nik: data?['nik'],
      img: data?['img'],
      isActive: data?['isActive'],
      isPickUsername: data?['isPickUsername'],
      level: data?['level'],
      pbsi: data?['pbsi'],
      skill: data?['skill'],
      username: data?['username'],
    );
  }

  
  Map<String, dynamic> toFirestore(){
    return {
      if (nama != null) 'nama' : nama,
      if (id != null) 'id' : id,
      if (email != null) 'email' : email,
      if (hp  != null) 'hp' : hp,
      if (nik  != null) 'nik' : nik,
      if (username  != null) 'username' : username,
      if (img  != null) 'img' : img,
      if (level  != null) 'level' : level,
      if (skill  != null) 'skill' : skill,
      if (pbsi  != null) 'pbsi' : pbsi,
      if (isActive  != null) 'isActive' : isActive,
      if (isPickUsername  != null) 'isPickUsername' : isPickUsername,

    };
  }
}