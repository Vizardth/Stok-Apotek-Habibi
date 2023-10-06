import 'package:cloud_firestore/cloud_firestore.dart';

class TotalTransaksi {
  String id;
  final int totalpenjualan;
  final int totalmodal;
  final DateTime waktupenjualan;
  final List? listitems;

  TotalTransaksi({
    this.id = '',
    required this.totalpenjualan,
    required this.totalmodal,
    required this.waktupenjualan,
    this.listitems,
  });

  Map<String, dynamic> toJson() => {
    'transaksiID' : id,
    'total_penjualan': totalpenjualan,
    'total_modal': totalmodal,
    'waktu_penjualan': waktupenjualan,
    'items' : listitems,
  };

  static TotalTransaksi fromJson(Map<String, dynamic> json) {


   return TotalTransaksi(
     id: json['transaksiID'],
      totalmodal: json['total_modal'],
      totalpenjualan: json['total_penjualan'],
      waktupenjualan: (json['waktu_penjualan'] as Timestamp).toDate(),

    );
  }
}

