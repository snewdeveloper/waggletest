import 'dart:io';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:wifi_iot/wifi_iot.dart';

import '../../../../core/utils/utilities.dart';
import '../../domain/entity/wifi_device.dart';
import '../../domain/repositories/wifi_repository.dart';


class WifiRepositoryImpl implements WifiRepository {
  final NetworkInfo _networkInfo = NetworkInfo();

  @override
  Future<WifiDevice> connect({
    required String ssid,
    required String password,
  }) async {
    print('WifiRepositoryImpl → connect() called');
   bool isEmulator = await isEmulatorDevice();
    /// 🔹 EMULATOR FLOW
    if (isEmulator) {
      print('Running on Android Emulator → simulating Wi-Fi connection');
      Random random= Random();

      await Future.delayed(const Duration(seconds: 1));

      return WifiDevice(
        ssid: ssid,
        isConnected: true,
        ip: '192.168.4.1',
        // simulated other iOT device info except wifi details
        signalStrength: 65 + random.nextInt(20),
        deviceName: 'Smart Cam X1',
        firmware: 'v1.3.${random.nextInt(10)}',
        battery: 40 + random.nextInt(60),
        storageUsed: 12,
        storageTotal: 64,
      );
    }

    /// 🔹 REAL DEVICE FLOW
    bool connected = false;

    if (Platform.isAndroid) {
      connected = await WiFiForIoTPlugin.connect(
        ssid,
        password: password,
        security: NetworkSecurity.WPA,
        joinOnce: true,
      );
    } else if (Platform.isIOS) {
      await AppSettings.openAppSettings();
    }

    final ip = await _networkInfo.getWifiIP();

    print('Connected: $connected');
    print('IP: $ip');
    print('SSID: $ssid');
    Random random= Random();
    return WifiDevice(
      ssid: ssid,
      isConnected: connected || Platform.isIOS,
      ip: ip,
      // simulated other iOT device info except wifi details
      signalStrength: 65 + random.nextInt(20),
      deviceName: 'Smart Cam X1',
      firmware: 'v1.3.${random.nextInt(10)}',
      battery: 40 + random.nextInt(60),
      storageUsed: 12,
      storageTotal: 64,
    );
  }
}
// import 'dart:io';
// import 'dart:math';
//
// import 'package:app_settings/app_settings.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:network_info_plus/network_info_plus.dart';
// import 'package:wifi_iot/wifi_iot.dart';
//
// import '../../domain/entity/wifi_device.dart';
// import '../../domain/repositories/wifi_repository.dart';
//
//
// class WifiRepositoryImpl implements WifiRepository {
//   final NetworkInfo _networkInfo = NetworkInfo();
//
//   @override
//   Future<WifiDevice> connect({
//     required String ssid,
//     required String password,
//   }) async {
//
//     bool connected = false;
//     print("WifiRepositoryImpl--connected--$connected");
//     if (Platform.isAndroid) {
//       connected = await WiFiForIoTPlugin.connect(
//         ssid,
//         password: password,
//         security: NetworkSecurity.WPA,
//         joinOnce: true,
//       );
//
//     } else if (Platform.isIOS) {
//       await AppSettings.openAppSettings();
//     }
//     print("WifiRepositoryImpl--connected after connection--$connected");
//
//     final ip = await _networkInfo.getWifiIP();
//     print("WifiRepositoryImpl--ip--$ip");
//     print("WifiRepositoryImpl--ssid--$ssid");
//
//     return WifiDevice(
//       ssid: ssid,
//       isConnected: connected || Platform.isIOS,
//       ip: ip,
//       signalStrength: 65 + Random().nextInt(20), // simulated
//     );
//   }
// }