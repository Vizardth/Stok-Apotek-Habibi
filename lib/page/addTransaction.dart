import 'package:apotek_habibi/Widget/cardwidget.dart';
import 'package:apotek_habibi/model/produkObat.dart';
import 'package:apotek_habibi/style/buttonwidget.dart';
import 'package:apotek_habibi/style/color.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../Widget/searchWidget.dart';
import '../controller/readProdukObat.dart';

class AddTransaction extends StatefulWidget {
  const AddTransaction({Key? key}) : super(key: key);

  @override
  _AddTransactionState createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  TextEditingController _SearchControllerTransaksi = TextEditingController();
  List<Produkobat> filteredProdukObatTransaksi = [];
  List<Produkobat> keranajangTambahTransaksi = [];

  bool iniKosong = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
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
                            'Rp,',
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        AutoSizeText(
                          '50000',
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
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
                    ontap: () {

                    },
                    coloricon: Colors.white,
                    sizeicon: 40,
                    radiusbutton: 20),
              ),
            ],
          ),
        ),
        key: scaffoldKey,
        backgroundColor: Warna.primarybackground,
        appBar: AppBar(
          backgroundColor: Warna.primarybackground,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
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
                          return Center(child: Text('Cari item diatas'));
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
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                return CardKeranjangTransaksi();
                              },

                            ),
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
