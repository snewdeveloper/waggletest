import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_location_updates.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocationUpdates getLocationUpdates;
  StreamSubscription? _subscription;

  LocationBloc(this.getLocationUpdates) : super(LocationInitial()) {
    on<StartLocationTracking>(_onStart);
    on<LocationUpdated>(_onUpdate);
  }

  void _onStart(
      StartLocationTracking event,
      Emitter<LocationState> emit,
      ) {
    emit(LocationLoading());

    _subscription = getLocationUpdates().listen(
          (location) {
        add(LocationUpdated(location));
      },
      onError: (e) {
        emit(LocationError(e.toString()));
      },
    );
  }

  void _onUpdate(
      LocationUpdated event,
      Emitter<LocationState> emit,
      ) {
    emit(LocationLoaded(event.location));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}