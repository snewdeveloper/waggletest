class DeviceHotspotQr {
  final String ssid;
  final String password;
  final String? deviceId;
  final String? security;
  final bool hidden;

  DeviceHotspotQr({
    required this.ssid,
    required this.password,
    this.deviceId,
    this.security,
    required this.hidden,
  });
}