import 'package:mobile_scanner/mobile_scanner.dart';


abstract class QrState {}

class QrInitial extends QrState {}

class QrScanning extends QrState {}

class QrScanSuccess extends QrState {
  final BarcodeCapture capture;
  QrScanSuccess(this.capture);
}

class QrScanFailure extends QrState {
  final String message;
  QrScanFailure(this.message);
}