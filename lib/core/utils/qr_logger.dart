import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter/foundation.dart';

class BarcodeLogger {
  static void log(BarcodeCapture capture) {
    debugPrint('📸 BarcodeCapture');
    debugPrint('• Frame size: ${capture.size}');
    debugPrint('• Raw data present: ${capture.raw != null}');
    debugPrint('• Barcode count: ${capture.barcodes.length}');

    for (var i = 0; i < capture.barcodes.length; i++) {
      final barcode = capture.barcodes[i];
      debugPrint('  └─ Barcode #$i');
      debugPrint('     • Format: ${barcode.format}');
      debugPrint('     • Raw value: ${barcode.rawValue}');
      debugPrint('     • Display value: ${barcode.displayValue}');
    }
  }
}