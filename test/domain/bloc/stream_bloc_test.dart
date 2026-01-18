import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:waggltest/features/live_stream/presentation/bloc/stream_bloc.dart';
import 'package:waggltest/features/live_stream/presentation/bloc/stream_event.dart';
import 'package:waggltest/features/live_stream/presentation/bloc/stream_state.dart';
import 'package:waggltest/features/live_stream/services/webrtc_simulator.dart';


class MockWebRtcSimulator extends Mock implements WebRtcSimulator {}
class MockRenderer extends Mock implements RTCVideoRenderer {}

void main() {
  late MockWebRtcSimulator simulator;
  late MockRenderer renderer;

  setUp(() {
    simulator = MockWebRtcSimulator();
    renderer = MockRenderer();
  });
  setUpAll(() {
    registerFallbackValue(MockRenderer());
  });

  blocTest<StreamBloc, StreamState>(
    'emits [StreamLoading, StreamActive] when StartStream is added',
    build: () {
      when(() => simulator.startSimulation(any()))
          .thenAnswer((_) async => MockMediaStream());
      return StreamBloc(simulator, renderer);
    },
    act: (bloc) => bloc.add(StartStream()),
    expect: () => [
      isA<StreamLoading>(),
      isA<StreamActive>(),
    ],
    verify: (_) {
      verify(() => simulator.startSimulation(renderer)).called(1);
    },
  );

  blocTest<StreamBloc, StreamState>(
    'emits [StreamStopped] when StopStream is added',
    build: () {
      when(() => simulator.stop()).thenAnswer((_) async {});
      return StreamBloc(simulator, renderer);
    },
    act: (bloc) => bloc.add(StopStream()),
    expect: () => [
      isA<StreamStopped>(),
    ],
    verify: (_) {
      verify(() => simulator.stop()).called(1);
    },
  );
}

class MockMediaStream extends Mock implements MediaStream {}