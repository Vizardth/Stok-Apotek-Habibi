import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListProdukHabis extends StatefulWidget {
  const ListProdukHabis({Key? key}) : super(key: key);

  @override
  _ListProdukHabisState createState() => _ListProdukHabisState();
}

class _ListProdukHabisState extends State<ListProdukHabis> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Stream<QuerySnapshot> produkStream;

  @override
  void initState() {
    super.initState();
    produkStream = FirebaseFirestore.instance
        .collection('produk')
        .where('jumlah_produk', isLessThan: 10)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          title: Text(
            'Produk Hampir Habis',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Readex Pro',
              fontSize: 25,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: produkStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Text('No products available.');
                    }

                    return Column(
                      children: snapshot.data!.docs.map((doc) {
                        var namaProduk = doc['nama_produk'];
                        var satuanProduk = doc['satuan_produk'];
                        var jumlahProduk = doc['jumlah_produk'];

                        return Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: Colors.grey[200],
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      satuanProduk,
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      namaProduk,
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Stok Tersisa - ',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          jumlahProduk.toString(),
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.red,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
