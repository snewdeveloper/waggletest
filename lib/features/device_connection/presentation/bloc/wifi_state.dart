import '../../domain/entity/wifi_device.dart';

abstract class WifiState {}

class WifiInitial extends WifiState {}

class WifiConnecting extends WifiState {}

class WifiConnected extends WifiState {
  final WifiDevice device;
  WifiConnected(this.device);
}

class WifiError extends WifiState {
  final String message;
  WifiError(this.message);
}