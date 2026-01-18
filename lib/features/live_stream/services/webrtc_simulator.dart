import 'package:flutter_webrtc/flutter_webrtc.dart';
import '../../../core/webrtc/webrtc_config.dart';

class WebRtcSimulator {
  RTCPeerConnection? _devicePeer;
  RTCPeerConnection? _viewerPeer;
  MediaStream? _localStream;

  Future<MediaStream> startSimulation(
      RTCVideoRenderer remoteRenderer,
      ) async {
    _localStream = await navigator.mediaDevices.getUserMedia({
      'video': true,
      'audio': false,
    });

    _devicePeer = await createPeerConnection(rtcConfig);
    _viewerPeer = await createPeerConnection(rtcConfig);

    for (var track in _localStream!.getTracks()) {
      _devicePeer!.addTrack(track, _localStream!);
    }

    _viewerPeer!.onTrack = (event) {
      remoteRenderer.srcObject = event.streams.first;
    };

    _devicePeer!.onIceCandidate =
        (candidate) => _viewerPeer!.addCandidate(candidate);

    _viewerPeer!.onIceCandidate =
        (candidate) => _devicePeer!.addCandidate(candidate);

    final offer = await _devicePeer!.createOffer();
    await _devicePeer!.setLocalDescription(offer);
    await _viewerPeer!.setRemoteDescription(offer);

    final answer = await _viewerPeer!.createAnswer();
    await _viewerPeer!.setLocalDescription(answer);
    await _devicePeer!.setRemoteDescription(answer);

    return _localStream!;
  }

  Future<void> stop() async {
    await _localStream?.dispose();
    await _devicePeer?.close();
    await _viewerPeer?.close();
  }
}