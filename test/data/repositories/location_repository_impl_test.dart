import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waggltest/features/location/domain/entities/location_entity.dart';
import 'package:waggltest/features/location/domain/repositories/location_repository.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late MockLocationRepository mockRepo;

  setUp(() {
    mockRepo = MockLocationRepository();
  });

  test('should emit a LocationEntity from repository', () async {
    final tLocation = LocationEntity(latitude: 10, longitude: 20, timestamp: DateTime.now());

    // Mock the method to return a finite stream
    when(() => mockRepo.getLocationStream())
        .thenAnswer((_) => Stream.value(tLocation));

    final stream = mockRepo.getLocationStream();

    await expectLater(stream, emits(tLocation));
  });
}