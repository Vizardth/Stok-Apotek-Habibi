import 'package:apotek_habibi/page/tabHome.dart';
import 'package:apotek_habibi/page/tabMedication.dart';
import 'package:apotek_habibi/page/tabTransaction.dart';
import 'package:apotek_habibi/style/color.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainTabV3 extends StatefulWidget {
  @override
  _MainTabV3State createState() => _MainTabV3State();
}

class _MainTabV3State extends State<MainTabV3> {
  int _page = 1;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 1,
          height: 60.0,
          items: <Widget>[
            Icon(Icons.medication, size: 30, color: Colors.white,),
            Icon(Icons.home, size: 30, color: Colors.white,),
            Icon(Icons.addchart, size: 30, color: Colors.white,),
          ],
          color: Warna.unguhabibi,
          buttonBackgroundColor: Warna.unguhabibi,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: screens[_page]
    );
  }
  final screens = [
    TabMedication(),
    TabHome(),
    TabTransaction(),
  ];
}