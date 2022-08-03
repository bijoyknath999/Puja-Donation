import 'package:flutter/material.dart';
import 'package:puja_donation/pages/index.dart';
import 'package:puja_donation/theme/colors.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: primary
    ),
    home: IndexPage(),
  ));
}