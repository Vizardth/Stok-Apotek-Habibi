import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/totalTransaksi.dart';

Stream<List<TotalTransaksi>> readTotalTransaksi() {
  return FirebaseFirestore.instance
      .collection('transaksi')
      .snapshots()
      .map((snapshots) =>
      snapshots.docs.map((doc) => TotalTransaksi.fromJson(doc.data()))
          .toList());
}

Stream<DocumentSnapshot<Map<String, dynamic>>> readItemsTransaksi(String idTransaksi) => FirebaseFirestore.instance.collection('transaksi').doc(idTransaksi).snapshots();