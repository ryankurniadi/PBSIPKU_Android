import 'package:cloud_firestore/cloud_firestore.dart';

class Turnamen {
  final String? id;
  final String? nama;
  final String? img;
  final String? status;
  final String? ket;
  final String? level;
  final String? lokasi;
  final String? kontak;
  final String? tipe;
  final int? limit;
  final int? biaya;
  final String? pbsi;
  final DateTime? date;
  final DateTime? batas;

  Turnamen(
      {this.id,
      this.limit,
      this.kontak,
      this.tipe,
      this.nama,
      this.img,
      this.lokasi,
      this.ket,
      this.status,
      this.date,
      this.biaya,
      this.level,
      this.batas,
      this.pbsi});

  factory Turnamen.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Turnamen(
      id: snapshot.id,
      nama: data?["nama"],
      img: data?["img"],
      limit: data?["limit"],
      kontak: data?["kontak"],
      tipe: data?["tipe"],
      biaya: data?["biaya"],
      status: data?["status"],
      ket: data?["ket"],
      level: data?["level"],
      pbsi: data?["pbsi"],
      lokasi: data?["lokasi"],
      date: data?["date"].toDate(),
      batas: data?["batas"].toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (ket != null) 'ket': ket,
      if (img != null) 'img': img,
      if (status != null) 'status': status,
      if (pbsi != null) 'pbsi': pbsi,
      if (limit != null) 'pbsi': limit,
      if (kontak != null) 'kontak': kontak,
      if (tipe != null) 'tipe': tipe,
      if (biaya != null) 'biaya': biaya,
      if (date != null) 'date': date,
      if (batas != null) 'batas': batas,
      if (lokasi != null) 'lokasi': lokasi,
      if (level != null) 'level': level,
    };
  }
}
