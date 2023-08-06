import 'package:cloud_firestore/cloud_firestore.dart';

class dropDownTransaksi {
  final String? namaproduk;
  final int? satuanproduk;
  final String? stokproduk;
  final int? hargaproduk;

  dropDownTransaksi({this.namaproduk, this.satuanproduk, this.stokproduk, this.hargaproduk});

  //Create a method to convert QuerySnapshot from Cloud Firestore to a list of objects of this DataModel
  //This function in essential to the working of FirestoreSearchScaffold

  List<dropDownTransaksi> dataListFromSnapshot(QuerySnapshot querySnapshot) {
    return querySnapshot.docs.map((snapshot) {
      final Map<String, dynamic> dataMap =
      snapshot.data() as Map<String, dynamic>;

      return dropDownTransaksi(
          namaproduk: dataMap['nama_produk'],
          satuanproduk: dataMap['satuan_produk'],
          stokproduk: dataMap['jumlah_produk'],
          hargaproduk: dataMap['harga_produk'],);
    }).toList();
  }
}