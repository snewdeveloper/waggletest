import 'dart:io';

import 'package:safe_device/safe_device.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

Future<bool> isEmulatorDevice()async {
  return !(await SafeDevice.isRealDevice); // Returns false if it is an emulator
}



class Utils {
  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
    );
  }
}