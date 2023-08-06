import 'package:cloud_firestore/cloud_firestore.dart';

Stream<int> readTotalDokumenTransaksi() {
  DateTime now = DateTime.now();
  DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
  DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59, 999);

  return FirebaseFirestore.instance
      .collection('transaksi')
      .where('waktu_penjualan', isGreaterThanOrEqualTo: firstDayOfMonth)
      .where('waktu_penjualan', isLessThanOrEqualTo: lastDayOfMonth)
      .snapshots()
      .map((snapshot) => snapshot.size);
}
