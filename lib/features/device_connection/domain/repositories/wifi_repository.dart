import '../../../device_connection/domain/entity/wifi_device.dart';

abstract class WifiRepository {
  Future<WifiDevice> connect({
    required String ssid,
    required String password,
  });
}