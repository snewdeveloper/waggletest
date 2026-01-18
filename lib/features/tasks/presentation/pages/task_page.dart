import 'package:flutter/material.dart';
import '../../../../core/routes/route_names.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, RouteNames.imagePicker),
              child: const Text('Capture / Attach Image'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, RouteNames.scanAndConnect),
              child: const Text('Scan & Connect'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, RouteNames.location),
              child: const Text('Location Tracking'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.pushNamed(context, RouteNames.webrtc),
              child: const Text('WEB Rtc'),
            ),
          ],
        ),
      ),
    );
  }
}