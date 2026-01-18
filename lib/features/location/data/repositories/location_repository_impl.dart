import 'package:geolocator/geolocator.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  @override
  Stream<LocationEntity> getLocationStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).map(
          (pos) => LocationEntity(
        latitude: pos.latitude,
        longitude: pos.longitude,
        timestamp: DateTime.now(),
      ),
    );
  }
}