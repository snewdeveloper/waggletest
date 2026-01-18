import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/webrtc_simulator.dart';
import 'stream_event.dart';
import 'stream_state.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

class StreamBloc extends Bloc<StreamEvent, StreamState> {
  final WebRtcSimulator simulator;
  final RTCVideoRenderer renderer;

  StreamBloc(this.simulator, this.renderer)
      : super(StreamInitial()) {
    on<StartStream>(_start);
    on<StopStream>(_stop);
  }

  Future<void> _start(
      StartStream event, Emitter<StreamState> emit) async {
    emit(StreamLoading());
    await simulator.startSimulation(renderer);
    emit(StreamActive());
  }

  Future<void> _stop(
      StopStream event, Emitter<StreamState> emit) async {
    await simulator.stop();
    emit(StreamStopped());
  }
}