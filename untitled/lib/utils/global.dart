import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';


import 'package:NewsApp/screen/homescreen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


import '../screen/Basescreen/basescreen.dart';
import '../screen/Basescreen/usercontroller.dart';
import '../screen/homescreen/search_screen.dart';
import 'comman_string.dart';

late UserController userController;
String initialRoute = BaseScreen.routeName;

globalVerbInit() {
  userController = Get.put(UserController());
}

void disposeKeyboard() {
  return FocusManager.instance.primaryFocus?.unfocus();
}

final List<NavigationTabContainModel> navigationTabList = [
  NavigationTabContainModel(icon: Icons.home, text: 'Everything'),
  NavigationTabContainModel(icon: Icons.flash_on, text: 'TopHeadline'),
  NavigationTabContainModel(icon: Icons.source_rounded, text: 'Suggested'),
];

class NavigationTabContainModel {
  final IconData icon;
  final String text;

  NavigationTabContainModel({required this.icon, required this.text});
}

List<Widget> navigationScreens = [
  HomeScreen(isAllNews: true),
  HomeScreen(isAllNews: false),
  SearchScreen(),
];

Future<bool> checkConnection() async {
  ConnectivityResult result = await Connectivity().checkConnectivity();
  return (result == ConnectivityResult.mobile ||
      result == ConnectivityResult.wifi);
}

flutterToast(String msg) {
  return Fluttertoast.showToast(
      msg: msg,
      textColor: Colors.black,
      backgroundColor: Colors.white,
      fontSize: 14);
}



