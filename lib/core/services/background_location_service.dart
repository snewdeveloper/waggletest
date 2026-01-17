import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:geolocator/geolocator.dart';

@pragma('vm:entry-point')
void backgroundLocationEntry(ServiceInstance service) async {

  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();

    service.setForegroundNotificationInfo(
      title: 'IoT GPS Active',
      content: 'Tracking device location',
    );
  }

  Timer.periodic(const Duration(seconds: 15), (timer) async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) return;

      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) return;

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      service.invoke('location_update', {
        'lat': position.latitude,
        'lng': position.longitude,
        'time': DateTime.now().toIso8601String(),
      });

      print('📍 BG LOCATION: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      print('🔥 BG ERROR: $e');
    }
  });
}