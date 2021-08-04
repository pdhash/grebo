import 'package:flutter/material.dart';
import 'package:get/get.dart';

AppBar appBar(String title) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Get.back();
      },
    ),
    // iconTheme: IconThemeData(
    //   color: Colors.black,
    // ),
    title: Text(
      title,
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
    ),
    backgroundColor: Colors.white,
  );
}
