import 'package:apotek_habibi/model/dropDownList.dart';
import 'package:apotek_habibi/style/buttonwidget.dart';
import 'package:apotek_habibi/style/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../model/produkObat.dart';

class EditMedication extends StatefulWidget {
  final Produkobat produk;

  const EditMedication({Key? key, required this.produk}) : super(key: key);

  @override
  _EditMedicationState createState() => _EditMedicationState();
}

class _EditMedicationState extends State<EditMedication> {
  final nama = TextEditingController();
  final stok = TextEditingController();
  final harga = TextEditingController();

  String? satuanobat;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    nama.text = widget.produk.nama;
    stok.text = widget.produk.stok.toString();
    harga.text = widget.produk.harga.toString();
    satuanobat = widget.produk.satuan;

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Warna.primarybackground,
        appBar: AppBar(
          backgroundColor: Warna.primarybackground,
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: true,
          title: Text(
            'Ubah Stok Produk',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Readex Pro',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [
            ButtonIcon(
                iconbutton: Icons.delete_forever,
                colorbutton: Warna.primarybackground,
                sizebutton: 50,
                ontap: () {QuickAlert.show(
                  context: context,
                  type: QuickAlertType.warning,
                  text: 'Hapus Data?',
                  confirmBtnText: 'Yes',
                  cancelBtnText: 'No',
                  confirmBtnColor: Warna.error,
                  showCancelBtn: true,
                  onConfirmBtnTap: ()async {
                    final QuerySnapshot snapshot = await FirebaseFirestore.instance
                        .collection('produk')
                        .where('nama_produk', isEqualTo: nama.text)
                        .get();

                    if (snapshot.docs.isNotEmpty) {
                      int count = 0;
                      final DocumentReference docRef = snapshot.docs.first.reference;
                      await docRef.delete();
                      Navigator.of(context).popUntil((_)=> count++ >=2);
                      QuickAlert.show(
                          context: context,
                          type: QuickAlertType.success,
                          customAsset: 'assets/deleteconfirm.gif',
                          title: 'Data Berhasil Dihapus',
                          confirmBtnColor: Warna.unguhabibi
                    );
                    } else {
                      print('Data with the given name does not exist.');
                    }
                  },
                );

                },
                coloricon: Warna.error,
                sizeicon: 30,
                radiusbutton: 0,
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25, 20, 25, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                          child: Text(
                            'Satuan Produk',
                            style:
                            TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(),
                          child: DropdownButton(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                            hint: Text('Pilih Satuan'),
                            value: satuanobat,
                            items: dropdownItems,
                            isExpanded: true,
                            underline: Container(),
                            onChanged: (String? newVal) {
                              setState(() {
                                satuanobat = newVal!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                          child: Text(
                            'Nama Produk',
                            style:
                            TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                            child: TextFormField(
                              enabled: false,
                              controller: nama,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Warna.alternate,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Warna.primary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Warna.error,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Warna.error,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                          child: Text(
                            'Jumlah Produk',
                            style:
                            TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                            child: TextFormField(
                              controller: stok,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Warna.alternate,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Warna.primary,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Warna.error,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedErrorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Warna.error,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                          child: Text(
                            'Harga Produk',
                            style:
                            TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                'Rp,',
                                style: TextStyle(
                                  color: Colors.black
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:
                                  EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                  child: TextFormField(
                                    controller: harga,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Warna.alternate,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Warna.primary,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      errorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                          Warna.error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedErrorBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                          Warna.error,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                    child: ButtonText (
                      textbutton: 'Simpan',
                      colorbutton: Warna.unguhabibi,
                      colortext: Colors.white,
                      sizetext: 20,
                      sizebutton: Size(50,50),
                      onpress: () {
                        final produk = Produkobat(
                          satuan: satuanobat!,
                          nama: nama.text,
                          stok: int.parse(stok.text),
                          harga: double.parse(harga.text),
                        );
                        createOrUpdateProdukobat(produk).then((_){
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
              if (_isLoading)
            Center(
            child: CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> createOrUpdateProdukobat(Produkobat produk) async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('produk')
        .where('nama_produk', isEqualTo: produk.nama)
        .get();

    if (snapshot.docs.isNotEmpty) {
      // If a matching entry already exists, update it with the new data
      final DocumentReference produkRef = snapshot.docs.first.reference;
      await produkRef.update(produk.toJson());
    } else {
      // If no matching entry exists, create a new one
      final DocumentReference produkRef =
      FirebaseFirestore.instance.collection('produk').doc();
      await produkRef.set(produk.toJson());
    }
  }
}
Stream<List<Produkobat>> readProdukobat() => FirebaseFirestore.instance
    .collection('produk')
    .snapshots()
    .map((snapshots) =>
    snapshots.docs.map((doc) => Produkobat.fromJson(doc.data())).toList());
