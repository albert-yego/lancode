import 'package:flutter/material.dart';
import 'package:get/get.dart';

final gWidth = Get.width;
final gHeight = Get.height;
final appBarHeight = Get.height / 7.7;
//

final Color appColor = Color(0xff4CB050);
final Color welcomeColor = Color(0xff747474);
final Color unFocusedText = Color(0xff9E9E9E);
final Color lineColor = Colors.grey;
final Color appBarUtilsColor = Colors.black;
final Color navigationBarUtilsColor = Colors.white;

AppBar appBar = AppBar(
  automaticallyImplyLeading: false,
  backgroundColor: appColor,
  toolbarHeight: appBarHeight,
  centerTitle: true,
  title: Text("PERSONNEL INFORMATION SYSTEM"),
);

String phoneN = "0534 706 7318";
String SMSCodeNumber = "123456";

FocusNode phone = FocusNode();
FocusNode SMS = FocusNode();
