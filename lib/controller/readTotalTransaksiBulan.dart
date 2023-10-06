import 'package:cloud_firestore/cloud_firestore.dart';

Stream<int> readTotalTransaksiBulan() {
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final endOfMonth = DateTime(now.year, now.month + 1, 1, 0, 0, 0).subtract(Duration(seconds: 1));


  return FirebaseFirestore.instance
      .collection('transaksi')
      .where('waktu_penjualan', isGreaterThanOrEqualTo: startOfMonth, isLessThanOrEqualTo: endOfMonth)
      .snapshots()
      .map((snapshot) {
    int total = 0;
    snapshot.docs.forEach((doc) {
      final totalPenjualan = (doc['total_penjualan'] as num?)?.toInt() ?? 0;
      total += totalPenjualan;
    });
    return total;
  });
}

Stream<int> readTotalModalBulan() {
  final now = DateTime.now();
  final startOfMonth = DateTime(now.year, now.month, 1);
  final endOfMonth = DateTime(now.year, now.month + 1, 1, 0, 0, 0).subtract(Duration(seconds: 1));


  return FirebaseFirestore.instance
      .collection('transaksi')
      .where('waktu_penjualan', isGreaterThanOrEqualTo: startOfMonth, isLessThanOrEqualTo: endOfMonth)
      .snapshots()
      .map((snapshot) {
    int total = 0;
    snapshot.docs.forEach((doc) {
      final totalModal = (doc['total_modal'] as num?)?.toInt() ?? 0;
      total += totalModal;
    });
    return total;
  });
}

