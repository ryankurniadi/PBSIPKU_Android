import 'package:cloud_firestore/cloud_firestore.dart';

class Turnamen{
  final String? id;
  final String? nama;
  final String? img;
  final String? status;
  final String? ket;
  final String? level;
  final DateTime? date;

  Turnamen({this.id, this.nama, this.img, this.ket, this.status, this.date, this.level});

  factory Turnamen.fromFirestore(
    DocumentSnapshot<Map<String,dynamic>> snapshot,
    SnapshotOptions? options
  ) {
    final data = snapshot.data();
    return Turnamen(
      id: snapshot.id,
      nama: data?["nama"],
      img: data?["img"],
      status: data?["status"],
      ket: data?["ket"],
      level: data?["level"],
      date: data?["date"].toDate(),
    );
  }

  Map<String, dynamic> toFirestore(){
    return {
      if(id != null) 'id':id,
      if(nama != null) 'nama':nama,
      if(ket != null) 'ket':ket,
      if(img != null) 'img':img,
      if(status != null) 'status':status,
      if(date != null) 'date':date,
      if(level != null) 'level':level,
    };
  }
}