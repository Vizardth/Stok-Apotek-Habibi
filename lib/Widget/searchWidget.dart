import 'package:apotek_habibi/Widget/cardwidget.dart';
import 'package:flutter/material.dart';

import '../model/produkObat.dart';

List<Produkobat> listData = [];

Widget buildProduk(Produkobat produkobat) =>
    CardWidgetProdukObat(produkobat: produkobat);

List<Produkobat> filterProdukList(List<Produkobat> data, String query) {
  if (query.isEmpty) {
    return data;
  }

  final lowercasequery = query.toLowerCase();

  return data.where((produkobat){
    final namaproduk = produkobat.nama.toLowerCase();
    final satuanproduk = produkobat.satuan.toLowerCase();
    return namaproduk.contains(lowercasequery) || satuanproduk.contains(lowercasequery);
  }).toList();
}

Widget buildProdukTransaksi(Produkobat produkobat) =>
    SearchProdukTransaksi(produkobat: produkobat);

Widget buildKeranjang(KeranjangProduk keranjangProduk) =>
    CardKeranjangTransaksi(keranjangproduk: keranjangProduk, onDelete: () {  },);

List<Produkobat> filterProdukListTransaksi(List<Produkobat> data, String query) {
  if(query.isEmpty){
    return [];
  }

  final lowercasequery = query.toLowerCase();

  return data.where((produkobat){
    final namaproduk = produkobat.nama.toLowerCase();
    final satuanproduk = produkobat.satuan.toLowerCase();
    return namaproduk.contains(lowercasequery) || satuanproduk.contains(lowercasequery);
  }).toList();
}


