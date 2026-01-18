import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';

import '../../services/webrtc_simulator.dart';
import '../bloc/stream_bloc.dart';
import '../bloc/stream_event.dart';
import '../bloc/stream_state.dart';

class LiveStreamPage extends StatefulWidget {
  final RTCVideoRenderer renderer;
  final WebRtcSimulator simulator;

  const LiveStreamPage({super.key, required this.renderer,required this.simulator});

  @override
  State<LiveStreamPage> createState() => _LiveStreamPageState();
}

class _LiveStreamPageState extends State<LiveStreamPage> {
  RTCVideoRenderer get _renderer => widget.renderer;

  @override
  void initState() {
    super.initState();
    _renderer.initialize();
  }

  @override
  void dispose() {
    _renderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          StreamBloc(widget.simulator, _renderer),
      child: Scaffold(
        appBar: AppBar(title: const Text('Live Stream')),
        body: BlocBuilder<StreamBloc, StreamState>(
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.black,
                    child: RTCVideoView(_renderer),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => context
                              .read<StreamBloc>()
                              .add(StartStream()),
                          child: const Text('Start Stream'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => context
                              .read<StreamBloc>()
                              .add(StopStream()),
                          child: const Text('Stop Stream'),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}