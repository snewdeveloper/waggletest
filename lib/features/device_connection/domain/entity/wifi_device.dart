class WifiDevice {
  final String ssid;
  final bool isConnected;
  final String? ip;
  final int signalStrength;

  // simulated IoT device info
  final String deviceName;
  final String firmware;
  final int battery;
  final int storageUsed;
  final int storageTotal;

  WifiDevice({
    required this.ssid,
    required this.isConnected,
    required this.ip,
    required this.signalStrength,
    required this.deviceName,
    required this.firmware,
    required this.battery,
    required this.storageUsed,
    required this.storageTotal,
  });
}