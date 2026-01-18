import 'package:permission_handler/permission_handler.dart';

class LocationPermissions {
  static Future<void> request() async {
    await Permission.location.request();
    await Permission.locationAlways.request();
    await Permission.notification.request();
  }
}