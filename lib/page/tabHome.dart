import 'package:apotek_habibi/page/listProdukHabis.dart';
import 'package:apotek_habibi/page/userGuidePDF.dart';
import 'package:apotek_habibi/style/color.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/d_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class TabHome extends StatefulWidget {
  const TabHome({super.key});

  @override
  State<TabHome> createState() => _TabHomeState();
}

class _TabHomeState extends State<TabHome> {
  final streamChart = FirebaseFirestore.instance.collection('transaksi').snapshots(includeMetadataChanges: true);
  @override
  Widget build(BuildContext context) {
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
      body:
      Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 15, 15, 0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Color(0xFF5D42FA),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: Text(
                                    'Selamat Datang Aplikasi Manajemen Stok Produk dan Penjualan Di Apotek Habibi. Gunakan Tombol Navigasi untuk Pindah \nKe Menu Lainnya',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ), // Intro To App
          Flexible(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('produk').where('jumlah_produk', isLessThan: 10).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  int totalDocuments = snapshot.data?.docs.length ?? 0;

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => ListProdukHabis()));
                    },
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Warna.error,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$totalDocuments',
                                style: TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                  fontSize: 50,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Produk Perlu Di Stok Ulang',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ), //Produk yang perlu di isi ulang
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('produk').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        int totalDocuments = snapshot.data?.docs.length ?? 0;

                        return Container(
                          width: double.infinity,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Color(0xFF3181A8),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 2),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        'Total Produk Tersimpan',
                                        style: TextStyle(
                                          fontFamily: 'Readex Pro',
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '$totalDocuments',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ), // Total Produk
                Flexible(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('transaksi').snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }

                        int totalTransactions = snapshot.data?.docs.length ?? 0;

                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Warna.secondary,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Total Seluruh Penjualan',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '$totalTransactions',
                                          style: TextStyle(
                                            fontFamily: 'Readex Pro',
                                            color: Colors.white,
                                            fontSize: 30,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                // Total Transaksi
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 0),
            child: Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Warna.secondarybackground,
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Total Penjualan Per-Hari',
                          style: TextStyle(
                            fontFamily: 'Readex Pro',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 200,
                    child:
                    StreamBuilder(
                      stream: streamChart,
                      builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something Went Wrong');
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text('Loading');
                        }
                        if (snapshot.data == null) {
                          return const Text('Empty');
                        }

                        Map<String, int> dayCounts = {};
                        snapshot.data!.docs.forEach((e) {
                          Timestamp timestamp = e.data()['waktu_penjualan'] as Timestamp;
                          DateTime dateTime = timestamp.toDate();
                          String formattedDate = DateFormat('MM-dd').format(dateTime);

                          dayCounts[formattedDate] = (dayCounts[formattedDate] ?? 0) + 1;
                        });
                        List<Map<String, dynamic>> listChart = dayCounts.entries.map((entry) {
                          return {
                            'domain': entry.key,
                            'measure': entry.value,
                          };
                        }).toList();

                        listChart.sort((a, b) => a['domain'].compareTo(b['domain']));

                        if (listChart.length > 7) {
                          listChart = listChart.sublist(listChart.length - 7);
                        }

                        return DChartBar(
                          data: [
                            {
                              'id': 'Bar',
                              'data': listChart,
                            },
                          ],
                          domainLabelPaddingToAxisLine: 16,
                          axisLineTick: 2,
                          axisLinePointTick: 2,
                          axisLinePointWidth: 10,
                          axisLineColor: Warna.unguhabibi,
                          barColor: (barData, index, id) => Color(0xff8722e1),
                          showBarValue: true,
                        );
                      },
                    ),

                  ),
                ],
              ),
            ),
          ), // Total Penjualan Chart
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
            child: GestureDetector(
              onTap: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserGuidePDFWidget())); },
              child: ListTile(
                title: Text(
                  'User Manual',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                subtitle: Text(
                  'Klik Disini Untuk Melihat Manual Aplikasi Untuk Pengguna',
                  style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontWeight: FontWeight.normal,
                  ),
                ),
                trailing: Icon(
                  Icons.question_mark_rounded,
                  color: Colors.black,
                  size: 35,
                ),
                tileColor: Warna.primarybackground,
                dense: false,
              ),
            ),
          ), // User Manual
        ],
      ),
    );
  }
}
