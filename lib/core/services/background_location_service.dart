import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';

@pragma('vm:entry-point')
void backgroundLocationEntry(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.setAsForegroundService();

    // 🔴 Initial notification (must be immediate)
    service.setForegroundNotificationInfo(
      title: 'Location Tracking',
      content: 'Initializing location...',
    );
  }

  Timer.periodic(const Duration(seconds: 10), (_) async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final lat = position.latitude.toStringAsFixed(5);
      final lng = position.longitude.toStringAsFixed(5);

      // 🔥 UPDATE notification with live coordinates
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: 'Tracking Location',
          content: 'Lat: $lat, Lng: $lng',
        );
      }

      // Optional: send to UI
      service.invoke('location_update', {
        'lat': position.latitude,
        'lng': position.longitude,
      });

    } catch (e) {
      if (service is AndroidServiceInstance) {
        service.setForegroundNotificationInfo(
          title: 'Location Tracking',
          content: 'Error fetching location',
        );
      }
    }
  });
}
//
// @pragma('vm:entry-point')
// void backgroundLocationEntry(ServiceInstance service) async {
//   if (service is AndroidServiceInstance) {
//     service.setAsForegroundService();
//     service.setForegroundNotificationInfo(
//       title: "Location Tracking",
//       content: "Service running",
//     );
//   }
//
//   Timer.periodic(const Duration(seconds: 15), (_) async {
//     if (!await Geolocator.isLocationServiceEnabled()) return;
//
//     final position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );
//
//     service.invoke(
//       'location_update',
//       {
//         'lat': position.latitude,
//         'lng': position.longitude,
//       },
//     );
//   });
// }