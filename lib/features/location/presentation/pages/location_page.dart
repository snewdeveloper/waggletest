import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../bloc/location_bloc.dart';
import '../bloc/location_event.dart';
import '../bloc/location_state.dart';


class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPS Tracking')),
      body: Center(
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationLoading) {
              return const CircularProgressIndicator();
            }
            if (state is LocationLoaded) {
              return Text(
                'Lat: ${state.location.latitude}\n'
                    'Lng: ${state.location.longitude}',
                textAlign: TextAlign.center,
              );
            }
            if (state is LocationError) {
              return Text(state.message);
            }
            return ElevatedButton(
              onPressed: ()async {
                await  Permission.notification.request();
                context.read<LocationBloc>().add(StartLocationTracking());
              },
              child: const Text('Start Tracking'),
            );
          },
        ),
      ),
    );
  }
}