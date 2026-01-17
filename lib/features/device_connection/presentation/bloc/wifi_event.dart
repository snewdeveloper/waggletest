abstract class WifiEvent {}

class ConnectToWifi extends WifiEvent {
  final String ssid;
  final String password;

  ConnectToWifi(this.ssid, this.password);
}