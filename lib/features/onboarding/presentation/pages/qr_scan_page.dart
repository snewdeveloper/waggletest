import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:waggltest/core/utils/qr_logger.dart';

import '../../../../core/utils/qr_parser.dart';
import '../../../device_connection/presentation/bloc/wifi_bloc.dart';
import '../../../device_connection/presentation/bloc/wifi_event.dart';
import '../../../device_connection/presentation/bloc/wifi_state.dart';
import '../../../device_connection/presentation/widgets/wifi_status_widget.dart';
import '../bloc/qr_bloc.dart';
import '../bloc/qr_event.dart';
import '../bloc/qr_state.dart';
import '../widgets/qr_details.dart';
import 'qr_camera_page.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key});

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final ImagePicker _picker = ImagePicker();
  String? extractedValue;

  Future<void> _scanFromGallery(BuildContext context) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final controller = MobileScannerController();
    final result = await controller.analyzeImage(image.path);

    if (result?.barcodes.isNotEmpty == false) {
      _showError('No QR code found in image');
      return;
    }
    if (result != null) {
      print(result);
      BarcodeLogger.log(result);
      context.read<QrBloc>().add(QrScanned(result));
    }
  }

  void _openCameraScanner(BuildContext context) async {
    final result = await Navigator.push<BarcodeCapture>(
      context,
      MaterialPageRoute(builder: (_) => const QrCameraPage()),
    );
    if (result != null) {
      print(result);
      BarcodeLogger.log(result);
      context.read<QrBloc>().add(QrScanned(result));
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan Device QR')),
      body: BlocListener<QrBloc, QrState>(
        listener: (context, state) {
          if (state is QrScanSuccess) {
            QrDetailsView(capture: state.capture);
          }
          if (state is QrScanFailure) {
            _showError(state.message);
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                /// 📸 Camera
                ElevatedButton.icon(
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Scan via Camera'),
                  onPressed: () => _openCameraScanner(context),
                ),

                const SizedBox(height: 12),

                /// 🖼 Gallery
                ElevatedButton.icon(
                  icon: const Icon(Icons.photo),
                  label: const Text('Scan via Gallery'),
                  onPressed: () => _scanFromGallery(context),
                ),

                const SizedBox(height: 24),

                /// 📄 Scan Result
                BlocBuilder<QrBloc, QrState>(
                  builder: (context, state) {
                    if (state is QrScanSuccess) {
                      final raw = state.capture.barcodes.first.rawValue;
                      print("raw---$raw");
                      if (raw != null) {
                        var wifi = QrParser.parse(raw);
                        print("wifi parsed--$wifi");

                        if (wifi != null) {
                          print("wifi not null");
                          context.read<WifiBloc>().add(
                            ConnectToWifi(wifi.ssid, wifi.password),
                          );
                          print("ConnectToWifi called");
                        }
                      }
                      return QrDetailsView(capture: state.capture);
                    }

                    return const Center(
                      child: Text(
                        'Scan a device_connection QR to see details',
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  },
                ),

                SizedBox(height: 45),
                BlocConsumer<WifiBloc, WifiState>(
                  listener: (context, state) {
                    if (state is WifiConnected) {
                      Fluttertoast.showToast(
                        msg: '✅ Connected to ${state.device.ssid}',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                      );
                    }

                    if (state is WifiError) {
                      Fluttertoast.showToast(
                        msg: state.message,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is WifiConnecting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is WifiConnected) {
                      return WifiStatusWidget(device: state.device);
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
