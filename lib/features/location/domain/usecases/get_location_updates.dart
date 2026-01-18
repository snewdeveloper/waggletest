import '../repositories/location_repository.dart';

class GetLocationUpdates {
  final LocationRepository repo;
  GetLocationUpdates(this.repo);

  call() => repo.getLocationStream();
}