import 'package:apotek_habibi/Widget/cardwidget.dart';
import 'package:apotek_habibi/model/produkObat.dart';
import 'package:apotek_habibi/style/buttonwidget.dart';
import 'package:apotek_habibi/style/color.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../Widget/searchWidget.dart';
import '../controller/readProdukObat.dart';

List<KeranjangProduk> addedProdukKeranjang = [];

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  TextEditingController _SearchControllerTransaksi = TextEditingController();
  List<Produkobat> filteredProdukObatTransaksi = [];
  final currencyFormatter = NumberFormat('#,##0', 'ID');

  bool iniKosong = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void updateUI(){
    setState(() {

    });
  }

  void uploadTransaction(List<KeranjangProduk> addedProdukKeranjang) async {
    CollectionReference transaksiCollection =
    FirebaseFirestore.instance.collection('transaksi');
    CollectionReference produkCollection =
    FirebaseFirestore.instance.collection('produk');

    final totalHarga = calculateTotalHarga();
    final totalModal = calculateTotalModal();
    List<Map<String, dynamic>> items = addedProdukKeranjang.map((produk) {
      return {
        'nama_item': produk.nama,
        'satuan_item': produk.satuan,
        'total_item': produk.jumlahproduksementara,
      };
    }).toList();

    bool allProductsAvailable = true;

    for (KeranjangProduk produk in addedProdukKeranjang) {
      final snapshot = await produkCollection
          .where('nama_produk', isEqualTo: produk.nama)
          .where('satuan_produk', isEqualTo: produk.satuan)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final availableStock = snapshot.docs[0]['jumlah_produk'];
        if (availableStock < produk.jumlahproduksementara) {
          allProductsAvailable = false;
          break;
        }
      }
    }

    if (!allProductsAvailable) {
      addedProdukKeranjang.clear();
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Gagal',
        text: 'Salah Satu Barang Habis',
        confirmBtnColor: Warna.unguhabibi,
      );
      return;
    }

    for (KeranjangProduk produk in addedProdukKeranjang) {
      final snapshot = await produkCollection
          .where('nama_produk', isEqualTo: produk.nama)
          .where('satuan_produk', isEqualTo: produk.satuan)
          .get();

      if (snapshot.docs.isNotEmpty) {
        final docId = snapshot.docs[0].id;
        final remainingStock =
            snapshot.docs[0]['jumlah_produk'] - produk.jumlahproduksementara;
        await produkCollection.doc(docId).update({
          'jumlah_produk': remainingStock,
        });
      }
    }

    DocumentReference transactionDoc = await transaksiCollection.add({
      'total_penjualan': totalHarga.toInt(),
      'total_modal' : totalModal.toInt(),
      'waktu_penjualan': Timestamp.now(),
      'items': items,
    });

    transactionDoc.set({
      'total_penjualan': totalHarga.toInt(),
      'total_modal' : totalModal.toInt(),
      'waktu_penjualan': Timestamp.now(),
      'items': items,
      'transaksiID': transactionDoc.id,
    });
    addedProdukKeranjang.clear();
    Navigator.pop(context);
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: 'Sukses',
      text: 'Transaksi Berhasil',
      confirmBtnColor: Warna.unguhabibi,
    );
  }



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {

    super.dispose();
  }
  Widget buildKeranjang(KeranjangProduk produk) {
    return CardKeranjangTransaksi(
      keranjangproduk: produk,
      onDelete: () {
        setState(() {
          addedProdukKeranjang.remove(produk);
        });
      },
    );
  }

  double calculateTotalHarga() {
    double totalHarga = 0;

    addedProdukKeranjang.forEach((element) {
      int quantity = element.jumlahproduksementara ?? 0;
      double hargaPerItem = element.hargajual ?? 0.0;
      totalHarga += quantity * hargaPerItem;
    });

    return totalHarga;
  }

  double calculateTotalModal() {
    double totalModal = 0;

    addedProdukKeranjang.forEach((element) {
      int quantity = element.jumlahproduksementara ?? 0;
      double modalPerItem = element.hargabeli ?? 0.0;
      totalModal += quantity * modalPerItem;
    });

    return totalModal;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                child: Container(
                  width: 240,
                  height: 50,
                  decoration: BoxDecoration(
                    color:
                    Warna.secondarybackground,
                    borderRadius: BorderRadius.circular(25),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      color: Color(0xFF8722E1),
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                          EdgeInsetsDirectional.fromSTEB(0, 0, 2, 0),
                          child: AutoSizeText(
                            'Rp ${currencyFormatter.format(calculateTotalHarga())}',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                child: ButtonIcon(
                  iconbutton: Icons.chevron_right_rounded,
                  colorbutton: Warna.unguhabibi,
                  sizebutton: 50,
                  ontap: () async {
                    uploadTransaction(addedProdukKeranjang);
                  },

                  coloricon: Colors.white,
                  sizeicon: 40,
                  radiusbutton: 20,
                ),
              ),
            ],
          ),
        ),
        key: scaffoldKey,
        backgroundColor: Warna.primarybackground,
        appBar: AppBar(
          backgroundColor: Warna.primarybackground,
          iconTheme: IconThemeData(color: Colors.black),
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: (){
              setState(() {
                addedProdukKeranjang.clear();
              });
              Navigator.of(context).pop();
            },
          ),
          automaticallyImplyLeading: false,
          title: Text(
            'Tambah Transaksi',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Readex Pro',
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.black
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                    child: TextFormField(
                      controller: _SearchControllerTransaksi,
                      onChanged: (value){
                        if(value.isNotEmpty){
                          setState(() {
                            iniKosong = false;
                          });
                        } else {
                          setState(() {
                            iniKosong = true;
                          });
                        }
                      },
                    )
                  ),
                  StreamBuilder<List<Produkobat>>(
                      stream: readProdukobat(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && iniKosong == false) {
                          final produk = snapshot.data!;
                          filteredProdukObatTransaksi = filterProdukListTransaksi(produk, _SearchControllerTransaksi.text);

                          return Container(
                            height: 200,
                            child: ListView(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              children: filteredProdukObatTransaksi.map(buildProdukTransaksi).toList(),
                            ),
                          );
                        } else {
                          return Center(child: Text('Cari Produk diatas'));
                        }
                      }
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Warna.secondarybackground,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32),),
                    ),
                    height: size.height * .4,

                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                color: Warna.secondarytext,
                                thickness: 4,
                                indent: 120,
                                endIndent: 120,
                              ),
                            ),
                      Container(
                        child: SingleChildScrollView(
                          child: ListView(physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: addedProdukKeranjang.map(buildKeranjang).toList(),
                          ),
                        ),
                      )
                          ],
                        ),
                      ),
                    )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
void addCart(Produkobat inidata) {
  bool productExists = false;

  for (KeranjangProduk keranjangProduk in addedProdukKeranjang) {
    if (keranjangProduk.nama == inidata.nama) {
      productExists = true;
      break;
    }
  }

  if (!productExists) {
    addedProdukKeranjang.add(KeranjangProduk(
      nama: inidata.nama,
      stok: inidata.stok,
      hargajual: inidata.hargajual,
      hargabeli: inidata.hargabeli,
      satuan: inidata.satuan,
      jumlahproduksementara: 1,
    ));
  }

  addedProdukKeranjang.forEach((element) {
    print(element.toJson());
    print(element.jumlahproduksementara);
  });
}






