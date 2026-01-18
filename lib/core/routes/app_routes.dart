import 'package:flutter/material.dart';
import 'package:waggltest/features/live_stream/presentation/pages/live_stream_page.dart';
import 'package:waggltest/features/location/presentation/pages/location_page.dart';
import 'package:waggltest/features/onboarding/presentation/pages/qr_scan_page.dart';
import '../../features/tasks/presentation/pages/task_page.dart';
import '../../features/image_picker/presentation/pages/image_picker_page.dart';
import 'route_names.dart';

class AppRoutes {
  static Route<dynamic> generate(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.tasks:
        return MaterialPageRoute(builder: (_) => const TaskPage());
      case RouteNames.imagePicker:
        return MaterialPageRoute(builder: (_) => const ImagePickerPage());
      case RouteNames.scanAndConnect:
        return MaterialPageRoute(builder: (_) => const QrScanPage());
      case RouteNames.webrtc:
        return MaterialPageRoute(builder: (_) => const LiveStreamPage());
      case RouteNames.location:
        return MaterialPageRoute(builder: (_) => const LocationPage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
