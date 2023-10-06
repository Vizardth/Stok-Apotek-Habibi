import 'package:apotek_habibi/model/dropDownList.dart';
import 'package:apotek_habibi/style/buttonwidget.dart';
import 'package:apotek_habibi/style/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../model/produkObat.dart';


class AddMedication extends StatefulWidget {
  const AddMedication({Key? key}) : super(key: key);


  @override
  _AddMedicationState createState() => _AddMedicationState();

}

class _AddMedicationState extends State<AddMedication> {
  final nama = TextEditingController();
  final stok = TextEditingController();
  final hargabeli = TextEditingController();
  final hargajual = TextEditingController();


  String? satuanobat;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLoading = false;


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
            'Tambah Stok Produk',
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Readex Pro',
              fontSize: 25,
              fontWeight: FontWeight.w600,
            ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(25, 60, 25, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 30),
                    child: Text(
                      'Masukkan Stok Produk\nYang Baru Disini',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
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
                            'Satuan Produk',
                            style:
                            TextStyle(
                              fontFamily: 'Readex Pro',
                              fontSize: 15,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                        DecoratedBox(
                          decoration: BoxDecoration(
                            color: Warna.secondarybackground,
                            borderRadius: BorderRadius.circular(5),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                blurRadius: 2)
                            ]
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 30, right: 30),
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
                              controller: nama,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: 'ex. Sanmol Forte 650mg',
                                hintStyle:
                                TextStyle(
                                  color: Colors.grey,
                                ),
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
                              keyboardType: TextInputType.numberWithOptions(decimal: true),
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                hintText: '0',
                                hintStyle:
                                TextStyle(
                                  color: Colors.grey
                                ),
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
                            'Harga Beli Produk',
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
                              padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                              child: TextFormField(
                                controller: hargabeli,
                                keyboardType: TextInputType.numberWithOptions(decimal: true), // Allow decimal numbers
                                autofocus: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  hintText: '0',
                                  hintStyle: TextStyle(color: Colors.grey),
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
                            'Harga Jual Produk',
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
                                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                  child: TextFormField(
                                    controller: hargajual,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true), // Allow decimal numbers
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: '0',
                                      hintStyle: TextStyle(color: Colors.grey),
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
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
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
                            hargabeli: double.parse(hargabeli.text),
                            hargajual: double.parse(hargajual.text),
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
    final CollectionReference produkRef = FirebaseFirestore.instance
        .collection('produk');

      final QuerySnapshot existingProductsSnapshot = await produkRef
          .where('nama_produk', isEqualTo: produk.nama)
          .where('satuan_produk', isEqualTo: produk.satuan)
          .get();

      if (existingProductsSnapshot.docs.isNotEmpty) {
        return QuickAlert.show(
          context: context,
          type: QuickAlertType.error,
          title: 'Error',
          text: 'Data Gagal Disimpan',
        );
      } else {
        final DocumentReference newDocRef = await produkRef.add(produk.toJson());
        final newId = newDocRef.id;
        produk.id = newId;
        await newDocRef.set(produk.toJson());

        Navigator.pop(context);
        return QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: 'Sukses',
          text: 'Data Berhasil Ditambahkan',
          confirmBtnColor: Warna.unguhabibi,
        );
      }
    }
  }


