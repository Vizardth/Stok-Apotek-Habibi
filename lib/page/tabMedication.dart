import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../Widget/searchWidget.dart';
import '../controller/readProdukObat.dart';
import '../model/produkObat.dart';
import '../style/buttonwidget.dart';
import '../style/color.dart';
import 'addMedication.dart';

class TabMedication extends StatefulWidget {
  const TabMedication({super.key});


  @override
  State<TabMedication> createState() => _TabMedicationState();
}

class _TabMedicationState extends State<TabMedication> {
  TextEditingController _SearchController = TextEditingController();
  List<Produkobat> filteredProdukObat = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF8722E1),
        automaticallyImplyLeading: false,
        title: Text(
          'Apotek Habibi',
          style: TextStyle(
            fontFamily: 'Outfit',
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0,0,20,0),
            child: InkWell(
              onTap: (){
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.confirm,
                  text: 'Do you want to logout?',
                  confirmBtnText: 'No',
                  cancelBtnText: 'Yes',
                  confirmBtnColor: Colors.red,
                  onCancelBtnTap: () async {
                    await FirebaseAuth.instance.signOut().whenComplete(() => Navigator.of(context).pop());
                  },
                );
              },
              child: Icon(Icons.logout_outlined),
            ),
          )
        ],
        centerTitle: false,
        elevation: 2,
      ),
      floatingActionButton: ButtonIcon
        (
        iconbutton: Icons.add,
        colorbutton: Warna.error,
        sizebutton: 50,
        ontap: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddMedication())); },
        coloricon: Colors.white,
        sizeicon: 35,
        radiusbutton: 20,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    8, 8, 8, 5),
                child: TextFormField(
                  controller: _SearchController,
                  onChanged: (value){
                    setState(() {

                    });
                  },
                  autofocus: false,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    labelStyle:
                    TextStyle(
                      fontFamily: 'Readex Pro',
                      fontWeight:
                      FontWeight.w300,
                    ),
                    hintStyle:
                    TextStyle(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Warna.alternate,
                        width: 2,
                      ),
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Warna.primary,
                        width: 2,
                      ),
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Warna.error,
                        width: 2,
                      ),
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    focusedErrorBorder:
                    OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Warna.error,
                        width: 2,
                      ),
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                  style: TextStyle(),
                ),
              ),
              Expanded(
                child: Container(
                  height: size.height,
                  child: StreamBuilder<List<Produkobat>>(
                      stream: readProdukobat(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final produk = snapshot.data!;
                          filteredProdukObat = filterProdukList(produk, _SearchController.text);

                          return ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: filteredProdukObat.map(buildProduk).toList(),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

