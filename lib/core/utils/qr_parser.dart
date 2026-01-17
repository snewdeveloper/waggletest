

import '../../features/onboarding/domain/entities/device_hotspot_qr.dart';

class QrParser {
  static DeviceHotspotQr? parse(String raw) {
    try {
      if (!raw.startsWith('WIFI:')) return null;

      final cleaned = raw.replaceFirst('WIFI:', '');
      final parts = cleaned.split(';');

      String? ssid;
      String? password;
      String? deviceId;
      String? security;
      bool hidden = false;

      for (final part in parts) {
        if (part.startsWith('S:')) {
          ssid = part.substring(2);
        } else if (part.startsWith('P:')) {
          password = part.substring(2);
        } else if (part.startsWith('ID:')) {
          deviceId = part.substring(3);
        } else if (part.startsWith('T:')) {
          security = part.substring(2);
        } else if (part.startsWith('H:')) {
          hidden = part.substring(2).toLowerCase() == 'true';
        }
      }

      if (ssid == null || password == null) {
        return null;
      }

      return DeviceHotspotQr(
        ssid: ssid,
        password: password,
        deviceId: deviceId, // optional
        security: security,
        hidden: hidden,
      );
    } catch (e) {
      print('QR parse error: $e');
      return null;
    }
  }
}