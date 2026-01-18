import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waggltest/features/onboarding/presentation/bloc/qr_event.dart';
import 'package:waggltest/features/onboarding/presentation/bloc/qr_state.dart';

class QrBloc extends Bloc<QrEvent, QrState> {
  QrBloc() : super(QrInitial()) {

    on<QrScanStarted>((event, emit) {
      emit(QrScanning());
    });
    on<ClearPreviousScan>((event, emit) {
      emit(QrInitial());
    });
    on<QrScanned>((event, emit) {
      if (event.capture.barcodes.isEmpty) {
        emit(QrScanFailure("No QR detected"));
        return;
      }
      emit(QrScanSuccess(event.capture));
    });
  }
}