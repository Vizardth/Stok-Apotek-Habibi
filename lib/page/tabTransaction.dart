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
  String selectedDuration = '1 Hari';
  List<String> durationOptions = ['1 Hari', '7 Hari', '30 Hari'];
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
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 10, 5),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton<String>(
                      value: selectedDuration,
                      items: durationOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) { // Change the argument type to String?
                        if (newValue != null) {
                          setState(() {
                            selectedDuration = newValue;
                          });
                          // Perform filtering here based on the selectedDuration
                          // Call a function that filters your transaction list
                          // and updates the UI accordingly.
                        }
                      },
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
                        if (snapshot.hasData) {
                          final transaksi = snapshot.data!;

                          // Calculate start dates for different durations
                          DateTime currentDate = DateTime.now();
                          DateTime startDate1Day = currentDate.subtract(Duration(days: 1));
                          DateTime startDate7Days = currentDate.subtract(Duration(days: 7));
                          DateTime startDate30Days = currentDate.subtract(Duration(days: 30));

                          // Create a list to store transactions that match the selected duration
                          final List<TotalTransaksi> filteredTransactions = [];

                          transaksi.forEach((totaltransaksi) {
                            DateTime transactionDate = totaltransaksi.waktupenjualan;

                            // Check if the transaction date is within the selected duration
                            if (selectedDuration == '1 Hari' && transactionDate.isAfter(startDate1Day)) {
                              filteredTransactions.add(totaltransaksi);
                            } else if (selectedDuration == '7 Hari' && transactionDate.isAfter(startDate7Days)) {
                              filteredTransactions.add(totaltransaksi);
                            } else if (selectedDuration == '30 Hari' && transactionDate.isAfter(startDate30Days)) {
                              filteredTransactions.add(totaltransaksi);
                            }
                          });

                          // Sort transactions in descending order (newest first)
                          filteredTransactions.sort((a, b) => b.waktupenjualan.compareTo(a.waktupenjualan));

                          final List<Widget> widgetList = [];

                          // Build widgets for each sorted transaction
                          filteredTransactions.forEach((totaltransaksi) {
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
