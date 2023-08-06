import 'package:cloud_firestore/cloud_firestore.dart';

class TotalOmset {
  final int totalPenjualanSum;

  TotalOmset(this.totalPenjualanSum);
}

Stream<TotalOmset> readTotalOmset() {
  return FirebaseFirestore.instance.collection('transaksi')
      .snapshots()
      .map((querySnapshot) {
    int totalSum = 0;
    for (QueryDocumentSnapshot docSnapshot in querySnapshot.docs) {
      totalSum += (docSnapshot.get('total_penjualan') as int); // Explicit cast to int
    }
    return TotalOmset(totalSum);
  });
}

