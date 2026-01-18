import 'dart:async';
import 'package:flutter/material.dart';

import '../domain/entities/location_entity.dart';
import '../domain/usecases/get_location_updates.dart';

class LocationViewModel extends ChangeNotifier {
  final GetLocationUpdates usecase;

  LocationEntity? current;
  StreamSubscription? _sub;

  LocationViewModel(this.usecase);

  void startListening() {
    _sub = usecase().listen((loc) {
      current = loc;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}