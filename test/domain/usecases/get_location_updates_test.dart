import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waggltest/features/location/domain/entities/location_entity.dart';
import 'package:waggltest/features/location/domain/repositories/location_repository.dart';
import 'package:waggltest/features/location/domain/usecases/get_location_updates.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late GetLocationUpdates usecase;
  late MockLocationRepository mockRepo;

  setUp(() {
    mockRepo = MockLocationRepository();
    usecase = GetLocationUpdates(mockRepo);
  });

  test('should return a stream of LocationEntity from repository', () {
    final tLocation = LocationEntity(latitude: 10, longitude: 20, timestamp: DateTime.now());
    when(() => mockRepo.getLocationStream()).thenAnswer((_) => Stream.value(tLocation));

    final result = usecase();

    expect(result, emits(tLocation));
    verify(() => mockRepo.getLocationStream()).called(1);
  });
}