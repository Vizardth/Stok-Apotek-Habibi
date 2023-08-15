
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/produkObat.dart';

Stream<List<Produkobat>> readProdukobat() => FirebaseFirestore.instance
    .collection('produk')
    .snapshots()
    .map((snapshots) =>
    snapshots.docs.map((doc) => Produkobat.fromJson(doc.data())).toList());

