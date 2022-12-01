import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnAppCloseController extends GetxController {
  DateTime? currentBackPressTime;

  Future<bool> onCloseApp(context) {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Please press back again to close the app",
            style: TextStyle(
                color: Color(0xff495895), fontWeight: FontWeight.w600),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xffF3F6FA),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)))));
      return Future.value(false);
    }
    return Future.value(true);
  }
}
