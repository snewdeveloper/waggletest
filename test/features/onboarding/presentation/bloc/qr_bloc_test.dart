import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:waggltest/features/onboarding/presentation/bloc/qr_bloc.dart';
import 'package:waggltest/features/onboarding/presentation/bloc/qr_event.dart';
import 'package:waggltest/features/onboarding/presentation/bloc/qr_state.dart';

// Mock classes
class MockBarcodeCapture extends Mock implements BarcodeCapture {}

void main() {
  group('QrBloc', () {
    late QrBloc qrBloc;
    late MockBarcodeCapture mockBarcodeCapture;

    setUp(() {
      qrBloc = QrBloc();
      mockBarcodeCapture = MockBarcodeCapture();
    });

    test('initial state is QrInitial', () {
      expect(qrBloc.state, equals( QrInitial()));
    });

    blocTest<QrBloc, QrState>(
      'emits [QrScanSuccess] when QrScanned is added with valid data',
      build: () => qrBloc,
      act: (bloc) => bloc.add(QrScanned(mockBarcodeCapture)),
      expect: () => [isA<QrScanSuccess>()],
    );

    blocTest<QrBloc, QrState>(
      'emits [QrInitial] when ClearPreviousScan is added',
      build: () => qrBloc,
      act: (bloc) => bloc.add(ClearPreviousScan()),
      expect: () => [isA<QrInitial>()],
    );
  });
}
