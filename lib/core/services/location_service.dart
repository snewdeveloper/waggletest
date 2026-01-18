import 'package:flutter_background_service/flutter_background_service.dart';
import 'background_location_service.dart';

class LocationService {
  static Future<void> start() async {
    final service = FlutterBackgroundService();

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: backgroundLocationEntry,
        isForegroundMode: true,
        autoStart: true,
        foregroundServiceTypes: [AndroidForegroundType.location]
        // foregroundServiceType: ForegroundServiceType.location,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: backgroundLocationEntry,
        onBackground: (_) => true,
      ),
    );

    service.startService();
  }
}