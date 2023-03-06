import 'package:first_app/app/core/values/colors.dart';
import 'package:first_app/app/core/values/icons.dart';
import 'package:flutter/material.dart';

List<Icon> getIcons() {
  return const [
    Icon(IconData(personIcon, fontFamily: "MaterialIcons"), color: purple),
    Icon(IconData(workIcon, fontFamily: "MaterialIcons"), color: blue),
    Icon(IconData(movieIcon, fontFamily: "MaterialIcons"), color: lightBlue),
    Icon(IconData(sportIcon, fontFamily: "MaterialIcons"), color: green),
    Icon(IconData(travelIcon, fontFamily: "MaterialIcons"), color: yellow),
  ];
}
