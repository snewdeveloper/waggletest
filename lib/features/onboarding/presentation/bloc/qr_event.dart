import 'package:mobile_scanner/mobile_scanner.dart';

abstract class QrEvent {}

class QrScanStarted extends QrEvent {}

class ClearPreviousScan extends QrEvent{}

class QrScanned extends QrEvent {
  final BarcodeCapture capture;
  QrScanned(this.capture);
}