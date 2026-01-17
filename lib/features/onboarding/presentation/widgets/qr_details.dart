import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../../core/utils/qr_parser.dart';
import '../../../device_connection/presentation/bloc/wifi_bloc.dart';
import '../../../device_connection/presentation/bloc/wifi_event.dart';

class QrDetailsView extends StatelessWidget {
  final BarcodeCapture capture;

  const QrDetailsView({required this.capture});

  @override
  Widget build(BuildContext context) {
    return

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Barcode information",style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),

        SizedBox(height: 20,),
        _infoTile('Frame Size', capture.size.toString()),
        _infoTile('Raw Data Present', capture.raw != null ? 'Yes' : 'No'),
        _infoTile('Barcodes Found', capture.barcodes.length.toString()),

        const Divider(height: 32),

        ...capture.barcodes.map((barcode) {
          return InkWell(
            onTap: (){
              final raw = barcode.rawValue;
              if (raw == null) return;

              final wifi = QrParser.parse(raw);
              if(wifi!=null){
                context.read<WifiBloc>().add(
                  ConnectToWifi(wifi.ssid, wifi.password),
                );
              }
            },
            child:Card(
            child:
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 6),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _infoTile('Format', barcode.format.toString()),
                    _infoTile('Raw Value', barcode.rawValue ?? 'N/A'),
                    _infoTile('Display Value', barcode.displayValue ?? 'N/A'),
                        SizedBox(height: 10,),
                        Text("TAP TO CONNECT")
                  ],
                ),
            ),),
          );
        }),
      ],
    );
  }

  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}