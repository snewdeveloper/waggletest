import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waggltest/features/location/domain/entities/location_entity.dart';
import 'package:waggltest/features/location/domain/usecases/get_location_updates.dart';
import 'package:waggltest/features/location/domain/repositories/location_repository.dart';
import 'package:waggltest/features/location/presentation/bloc/location_bloc.dart';
import 'package:waggltest/features/location/presentation/bloc/location_event.dart';
import 'package:waggltest/features/location/presentation/bloc/location_state.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late MockLocationRepository mockRepo;
  late GetLocationUpdates usecase;
  late LocationBloc bloc;

  setUp(() {
    mockRepo = MockLocationRepository();
    usecase = GetLocationUpdates(mockRepo);
    bloc = LocationBloc(usecase);
  });

  final tLocation = LocationEntity(latitude: 10, longitude: 20, timestamp: DateTime.now());

  blocTest<LocationBloc, LocationState>(
    'emits [LocationLoading, LocationLoaded] when StartLocationTracking is added',
    build: () {
      when(() => mockRepo.getLocationStream())
          .thenAnswer((_) => Stream.value(tLocation)); // finite stream
      return bloc;
    },
    act: (bloc) => bloc.add(StartLocationTracking()),
    expect: () => [
      isA<LocationLoading>(),
      isA<LocationLoaded>(),
    ],
  );
}