import 'package:apotek_habibi/controller/readTotalTransaksi.dart';
import 'package:apotek_habibi/model/totalTransaksi.dart';
import 'package:apotek_habibi/page/editMedication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../controller/readTotalDokumenTransaksi.dart';
import '../controller/readTotalTransaksiBulan.dart';
import '../model/produkObat.dart';
import '../style/buttonwidget.dart';
import '../style/color.dart';
import 'package:intl/date_symbol_data_local.dart';


class CardWidgetProdukObat extends StatefulWidget {
  final Produkobat produkobat;
  CardWidgetProdukObat({super.key, required this.produkobat});

  @override
  State<CardWidgetProdukObat> createState() => _CardWidgetProdukObatState();
}
class _CardWidgetProdukObatState extends State<CardWidgetProdukObat> {
  final currencyFormatter = NumberFormat('#,##0', 'ID');
  @override
  Widget build(BuildContext context) {
    double harga = widget.produkobat.harga;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditMedication(
            produk: widget.produkobat,
          ),
        ));
      },
      child: Card(
        clipBehavior:
        Clip.antiAliasWithSaveLayer,
        color: Warna.secondarybackground,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional
              .fromSTEB(10, 10, 10, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize:
                MainAxisSize.max,
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [
                  Row(
                    mainAxisSize:
                    MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment
                        .start,
                    children: [
                      Text(
                        widget.produkobat.satuan,
                        style: const TextStyle(
                          fontFamily:
                          'Readex Pro',
                          color: Warna.primarytext,
                          fontSize: 16,
                          fontWeight:
                          FontWeight
                              .normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  mainAxisSize:
                  MainAxisSize.max,
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    Row(
                      mainAxisSize:
                      MainAxisSize.max,
                      children: [
                        Text(
                          widget.produkobat.nama,
                          style: const TextStyle(
                            fontFamily:
                            'Readex Pro',
                            color: Warna.primarytext,
                            fontSize: 18,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize:
                      MainAxisSize.max,
                      children: [
                        const Text(
                          'Rp,',
                          style: TextStyle(
                            fontFamily:
                            'Readex Pro',
                            color: Warna.tertiary,
                            fontWeight:
                            FontWeight
                                .w600,
                          ),
                        ),
                        Text(
                          '${currencyFormatter.format(harga)}',
                          style: const TextStyle(
                            fontFamily:
                            'Readex Pro',
                            color: Warna.tertiary,
                            fontWeight:
                            FontWeight
                                .w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize:
                MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize:
                    MainAxisSize.max,
                    children: [
                      const Text(
                        'Stok - ',
                        style: TextStyle(
                          fontFamily:
                          'Readex Pro',
                          color: Warna.secondarytext,
                          fontSize: 14,
                          fontWeight:
                          FontWeight
                              .w400,
                        ),
                      ),
                      Text(
                        widget.produkobat.stok.toString(),
                        style: const TextStyle(
                          fontFamily:
                          'Readex Pro',
                          color: Warna.secondarytext,
                          fontSize: 14,
                          fontWeight:
                          FontWeight
                              .w400,
                        ),
                      ),
                    ],
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


class CardWidgetOmset extends StatelessWidget {
  final int totalPenjualanSum;

  CardWidgetOmset({required this.totalPenjualanSum});

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ID', null);
    return buildOmset(totalPenjualanSum);
  }

  Widget buildOmset(totalPenjualanSum) {
    final totalPenjualanSumFormat = NumberFormat('#,##0', 'ID').format(
        totalPenjualanSum);

    final date1 = DateTime.now();
    final monthYearDayFormatter = DateFormat('dd-MM-yyyy', 'ID');
    final currentMonthYearDay = monthYearDayFormatter.format(date1);

    final date2 = DateTime.now();
    final monthYearFormatter = DateFormat('MMMM yyyy', 'ID');
    final currentMonthYear = monthYearFormatter.format(date2);

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color(0xFF9B24FF),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Omset',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 2, 5, 3),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Rp,',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '$totalPenjualanSumFormat',
                      style: const TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      currentMonthYearDay,
                      style: const TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 3),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    StreamBuilder<int>(
                      stream: readTotalDokumenTransaksi(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text(
                            'Loading...',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Text(
                            'Error fetching data',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                            ),
                          );
                        } else {
                          final transactionCount = snapshot.data!;
                          return Row(
                            children: [
                              Text(
                                '$transactionCount',
                                style: const TextStyle(
                                  fontFamily: 'Readex Pro',
                                  color: Colors.white,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    4, 0, 0, 0),
                                child: Text(
                                  'Transaksi Bulan Ini',
                                  style: TextStyle(
                                    fontFamily: 'Readex Pro',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(5, 0, 5, 5),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Total Omset Bulan ',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      currentMonthYear,
                      style: const TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Rp,',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        color: Colors.white,
                      ),
                    ),
                    StreamBuilder<int>(
                      stream: readTotalTransaksiBulan(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Text(
                            'Loading...',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Text(
                            'Error fetching data',
                            style: TextStyle(
                              fontFamily: 'Readex Pro',
                              color: Colors.white,
                            ),
                          );
                        } else {
                          if (snapshot.data == null) {
                            return const Text(
                              'No data available',
                              style: TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
                              ),
                            );
                          } else {
                            final omsetBulan = snapshot.data!;
                            final omsetBulanFormat = NumberFormat('#,##0', 'ID').format(omsetBulan);
                            return Text(
                              '$omsetBulanFormat',
                              style: const TextStyle(
                                fontFamily: 'Readex Pro',
                                color: Colors.white,
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


Widget buildpenjualan(BuildContext context, TotalTransaksi transaksi) {
  int totalpenjualan = transaksi.totalpenjualan;
  final currencyFormatter = NumberFormat('#,##0', 'ID');

  DateTime dateTime = transaksi.waktupenjualan;
  String formattedDateTime = DateFormat('dd-MMMM HH:mm').format(dateTime);
  return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Warna.secondarybackground,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.show_chart,
                      color: Color(0xFF3DDA6A),
                      size: 30,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  const Text(
                                    'Rp,',
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Warna.tertiary,
                                    ),
                                  ),
                                  Text(
                                    '${currencyFormatter.format(totalpenjualan)}',
                                    style: const TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Warna.tertiary,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    formattedDateTime,
                                    style: const TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Warna.primarytext,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            child: StreamBuilder(
                stream: readItemsTransaksi(transaksi.id),
                builder: (context, snapshot) {
                  print(transaksi.id);
                  if(snapshot.hasData){
                    List items = snapshot.data?['items'];
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index){
                        var item = items[index];
                        return Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    item['nama_item'],
                                    style: const TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Warna.primarytext,
                                    ),
                                  ),
                                  const Padding(
                                    padding:
                                    EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                    child: Text(
                                      'x',
                                      style: TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: Warna.secondarytext,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsetsDirectional.fromSTEB(1, 0, 0, 0),
                                    child: Text(
                                      item['total_item'].toString(),
                                      style: const TextStyle(
                                        fontFamily: 'Readex Pro',
                                        color: Warna.secondarytext,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    item['satuan_item'],
                                    style: TextStyle(
                                      fontFamily: 'Readex Pro',
                                      color: Warna.secondarytext,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );

                  } else {
                    return Center(child: CircularProgressIndicator(),);
                  }
                }
            ),
          ),
        ],
      ),
    );
}


class CardWidgetProdukObatTransaksi extends StatefulWidget {
  final Produkobat produkobat;
  CardWidgetProdukObatTransaksi({super.key, required this.produkobat});

  @override
  State<CardWidgetProdukObatTransaksi> createState() => _CardWidgetProdukObatTransaksiState();
}
class _CardWidgetProdukObatTransaksiState extends State<CardWidgetProdukObatTransaksi> {
  final currencyFormatter = NumberFormat('#,##0', 'ID');
  @override
  Widget build(BuildContext context) {
    double harga = widget.produkobat.harga;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => EditMedication(
            produk: widget.produkobat,
          ),
        ));
      },
      child: Card(
        clipBehavior:
        Clip.antiAliasWithSaveLayer,
        color: Warna.primarybackground,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional
              .fromSTEB(10, 10, 10, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize:
                MainAxisSize.max,
                mainAxisAlignment:
                MainAxisAlignment
                    .spaceBetween,
                children: [
                  Row(
                    mainAxisSize:
                    MainAxisSize.max,
                    mainAxisAlignment:
                    MainAxisAlignment
                        .start,
                    children: [
                      Text(
                        widget.produkobat.satuan,
                        style: const TextStyle(
                          fontFamily:
                          'Readex Pro',
                          color: Warna.primarytext,
                          fontSize: 16,
                          fontWeight:
                          FontWeight
                              .normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Row(
                  mainAxisSize:
                  MainAxisSize.max,
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [
                    Row(
                      mainAxisSize:
                      MainAxisSize.max,
                      children: [
                        Text(
                          widget.produkobat.nama,
                          style: const TextStyle(
                            fontFamily:
                            'Readex Pro',
                            color: Warna.primarytext,
                            fontSize: 18,
                            fontWeight:
                            FontWeight
                                .bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize:
                      MainAxisSize.max,
                      children: [
                        const Text(
                          'Rp,',
                          style: TextStyle(
                            fontFamily:
                            'Readex Pro',
                            color: Warna.tertiary,
                            fontWeight:
                            FontWeight
                                .w600,
                          ),
                        ),
                        Text(
                          '${currencyFormatter.format(harga)}',
                          style: const TextStyle(
                            fontFamily:
                            'Readex Pro',
                            color: Warna.tertiary,
                            fontWeight:
                            FontWeight
                                .w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize:
                MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize:
                    MainAxisSize.max,
                    children: [
                      const Text(
                        'Stok - ',
                        style: TextStyle(
                          fontFamily:
                          'Readex Pro',
                          color: Warna.secondarytext,
                          fontSize: 14,
                          fontWeight:
                          FontWeight
                              .w400,
                        ),
                      ),
                      Text(
                        widget.produkobat.stok.toString(),
                        style: const TextStyle(
                          fontFamily:
                          'Readex Pro',
                          color: Warna.secondarytext,
                          fontSize: 14,
                          fontWeight:
                          FontWeight
                              .w400,
                        ),
                      ),
                    ],
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


class CardKeranjangTransaksi extends StatefulWidget {
  const CardKeranjangTransaksi({super.key});

  @override
  State<CardKeranjangTransaksi> createState() => _CardKeranjangTransaksiState();
}
class _CardKeranjangTransaksiState extends State<CardKeranjangTransaksi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 8, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Nama Produk',
                      style: TextStyle(
                        fontFamily: 'Readex Pro',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 8),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 1, 0),
                      child: Text(
                        'Rp,',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Text(
                      'Harga',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional
                        .fromSTEB(0, 0, 5, 0),
                    child: ButtonIcon(
                      iconbutton: Icons.delete,
                      colorbutton: Colors.transparent,
                      sizebutton: 40,
                      ontap: () {},
                      coloricon: Warna.error,
                      sizeicon: 24,
                      radiusbutton: 20,
                    ),
                  ),
                  ButtonIcon(
                      iconbutton: Icons.remove_rounded,
                      colorbutton: Color(0xFF2E92F1),
                      sizebutton: 40,
                      ontap: () {},
                      coloricon: Colors.white,
                      sizeicon: 24,
                      radiusbutton: 20
                  ),
                  Container(
                    width: 50,
                    decoration: BoxDecoration(),
                    child: Padding(
                      padding: EdgeInsetsDirectional
                          .fromSTEB(5, 0, 5, 0),
                      child: TextFormField(
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: '0',
                          hintStyle: TextStyle(color: Colors.grey),
                          enabledBorder:
                          UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                              Warna.alternate,
                              width: 2,
                            ),
                            borderRadius:
                            BorderRadius.circular(
                                8),
                          ),
                          focusedBorder:
                          UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                              Warna.primary,
                              width: 2,
                            ),
                            borderRadius:
                            BorderRadius.circular(
                                8),
                          ),
                          errorBorder:
                          UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                              Warna.error,
                              width: 2,
                            ),
                            borderRadius:
                            BorderRadius.circular(
                                8),
                          ),
                          focusedErrorBorder:
                          UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:
                              Warna.error,
                              width: 2,
                            ),
                            borderRadius:
                            BorderRadius.circular(
                                8),
                          ),
                        ),
                        style: TextStyle(
                          fontFamily:
                          'Readex Pro',
                          fontSize: 16,
                          fontWeight:
                          FontWeight.normal,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  ButtonIcon(
                      iconbutton: Icons.add_rounded,
                      colorbutton: Color(0xFF2E92F1),
                      sizebutton: 40,
                      ontap: () {},
                      coloricon: Colors.white,
                      sizeicon: 24,
                      radiusbutton: 20
                  ),
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}
