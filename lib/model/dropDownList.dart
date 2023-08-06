import 'package:flutter/material.dart';

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    DropdownMenuItem(child: Text("Kapsul"), value: "Kapsul"),
    DropdownMenuItem(child: Text("Tablet"), value: "Tablet"),
    DropdownMenuItem(child: Text("Botol"), value: "Botol"),
    DropdownMenuItem(child: Text("Papan"), value: "Papan"),
    DropdownMenuItem(child: Text("Box"), value: "Box"),
    DropdownMenuItem(child: Text("Buah"), value: "Buah"),
  ];
  return menuItems;
}