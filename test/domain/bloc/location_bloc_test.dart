import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:waggltest/features/location/domain/entities/location_entity.dart';
import 'package:waggltest/features/location/domain/usecases/get_location_updates.dart';
import 'package:waggltest/features/location/presentation/bloc/location_bloc.dart';
import 'package:waggltest/features/location/presentation/bloc/location_event.dart';
import 'package:waggltest/features/location/presentation/bloc/location_state.dart';

class MockGetLocationUpdates extends Mock implements GetLocationUpdates {}

void main() {
  late LocationBloc bloc;
  late MockGetLocationUpdates mockUsecase;

  setUp(() {
    mockUsecase = MockGetLocationUpdates();
    bloc = LocationBloc(mockUsecase);
  });

  final tLocation = LocationEntity(latitude: 10, longitude: 20, timestamp: DateTime.now());

  blocTest<LocationBloc, LocationState>(
    'emits [LocationLoading, LocationLoaded] when StartLocationTracking is added',
    build: () {
      when(() => mockUsecase()).thenAnswer((_) => Stream.value(tLocation));
      return bloc;
    },
    act: (bloc) => bloc.add(StartLocationTracking()),
    expect: () => [
      // LocationLoading(),
      // LocationLoaded(tLocation),
      isA<LocationLoading>(),
      isA<LocationLoaded>(),
    ],
  );
}