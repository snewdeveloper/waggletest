import '../../domain/entities/location_entity.dart';

abstract class LocationEvent {}

class StartLocationTracking extends LocationEvent {}

class LocationUpdated extends LocationEvent {
  final LocationEntity location;
  LocationUpdated(this.location);
}