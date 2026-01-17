import 'package:flutter/material.dart';
import '../../domain/entity/wifi_device.dart';

class WifiStatusWidget extends StatelessWidget {
  final WifiDevice device;

  const WifiStatusWidget({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Wifi Device information",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),
        Card(
          color: Colors.grey.withValues(alpha: 0.1),
          child: ListTile(
            leading: Icon(
              device.isConnected ? Icons.wifi : Icons.wifi_off,
              color: device.isConnected ? Colors.green : Colors.red,
            ),
            title: Text(device.ssid),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Connected: ${device.isConnected ? "Yes" : "No"}'),
                Text('IP: ${device.ip ?? "--"}'),
                Text('Signal: ${device.signalStrength}%'),
                Text('Battery: ${device.battery}%'),
                Text('Device Name: ${device.deviceName}'),
                Text('Storage Total: ${device.storageTotal}%'),
                Text('Storage Used: ${device.storageUsed}%'),
                Text('Firmware: ${device.firmware}'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}