import 'package:apotek_habibi/controller/readTotalTransaksi.dart';
import 'package:apotek_habibi/model/totalTransaksi.dart';
import 'package:apotek_habibi/page/addTransaction.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import '../Widget/cardwidget.dart';
import '../controller/readOmset.dart';
import '../style/buttonwidget.dart';
import '../style/color.dart';

class TabTransaction extends StatefulWidget {
  const TabTransaction({super.key});

  @override
  State<TabTransaction> createState() => _TabTransactionState();
}


class _TabTransactionState extends State<TabTransaction> {
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
        colorbutton: Warna.secondary,
        sizebutton: 50,
        ontap: () { Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTransaction())); },
        coloricon: Colors.white,
        sizeicon: 35,
        radiusbutton: 20,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              StreamBuilder<TotalOmset>(
                stream: readTotalOmset(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error fetching data');
                  } else {
                    int totalPenjualanSum = snapshot.data?.totalPenjualanSum ?? 0;
                    // Display the total sum inside the CardWidget
                    return CardWidgetOmset(totalPenjualanSum: totalPenjualanSum);
                  }
                },
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    0, 5, 10, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment:
                  MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional
                          .fromSTEB(0, 0, 5, 0),
                      child: Text(
                        'Filter',
                        style:
                        TextStyle(
                          fontFamily:
                          'Readex Pro',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.filter_list,
                      color: Colors.black,
                      size: 24,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: size.height,
                  child: StreamBuilder<List<TotalTransaksi>>(
                      stream: readTotalTransaksi(),
                      builder: (context, snapshot) {
                        print('Snapshot data: ${snapshot.data}');
                        if (snapshot.hasData) {
                          final transaksi = snapshot.data!;
                          final List<Widget> widgetList = [];
                          transaksi.forEach((totaltransaksi) {
                            widgetList.add(buildpenjualan(context, totaltransaksi));
                          });
                          return ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: widgetList,
                          );
                        }  else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                  ),
                ),
              ),
            ],
          )
        ],
      )
    );
  }
}
