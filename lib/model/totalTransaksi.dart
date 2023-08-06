import 'package:cloud_firestore/cloud_firestore.dart';

class TotalTransaksi {
  String id;
  final int totalpenjualan;
  final DateTime waktupenjualan;
  final List? listitems;

  TotalTransaksi({
    this.id = '',
    required this.totalpenjualan,
    required this.waktupenjualan,
    this.listitems,
  });

  Map<String, dynamic> toJson() => {
    'transaksiID' : id,
    'total_penjualan': totalpenjualan,
    'waktu_penjualan': waktupenjualan,
  };

  static TotalTransaksi fromJson(Map<String, dynamic> json) {


   return TotalTransaksi(
     id: json['transaksiID'],
      totalpenjualan: json['total_penjualan'],
      waktupenjualan: (json['waktu_penjualan'] as Timestamp).toDate(),

    );
  }
}

