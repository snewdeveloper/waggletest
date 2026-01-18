import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/repositories/wifi_repository.dart';
import 'wifi_event.dart';
import 'wifi_state.dart';

class WifiBloc extends Bloc<WifiEvent, WifiState> {
  final WifiRepository repository;

  WifiBloc(this.repository) : super(WifiInitial()) {
    on<ConnectToWifi>((event, emit) async {
      emit(WifiConnecting());
      try {
        final device = await repository.connect(
          ssid: event.ssid,
          password: event.password,
        );
        emit(WifiConnected(device));
      } catch (e) {
        emit(WifiError(e.toString()));
      }
    });
    on<ClearPreviousWifiState>((event, emit) {
      emit(WifiInitial());
    });

  }
}