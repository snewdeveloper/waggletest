import 'package:flutter_background_service/flutter_background_service.dart';
import 'background_location_service.dart';

Future<void> startBackgroundLocationService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: backgroundLocationEntry,
      isForegroundMode: true,
      autoStart: false,
      notificationChannelId: 'location_channel',
      initialNotificationTitle: 'IoT Tracking',
      initialNotificationContent: 'Starting location service',
      foregroundServiceTypes: [
        AndroidForegroundType.location
      ],
    ),
    iosConfiguration: IosConfiguration(
      onForeground: backgroundLocationEntry,
      onBackground: (_) => false,
    ),
  );

  await service.startService();
}