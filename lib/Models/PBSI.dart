import 'package:cloud_firestore/cloud_firestore.dart';

class PBSI{
  final String? nama;
  final String? id;

  PBSI({this.nama, this.id});

  factory PBSI.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ){
    final data = snapshot.data();
    return PBSI(
      nama: data?['nama'],
      id: snapshot.id
    );
  }

  Map<String, dynamic> toFirestore(){
    return {
      if (nama != null) 'nama' : nama,
      if (id != null) 'id' : id,
    };
  }


}

