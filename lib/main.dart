import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waggltest/features/device_connection/data/repositories/wifi_repository_impl.dart';
import 'package:waggltest/features/device_connection/domain/repositories/wifi_repository.dart';
import 'package:waggltest/features/device_connection/presentation/bloc/wifi_bloc.dart';
import 'package:waggltest/features/image_picker/presentation/bloc/image_picker_bloc.dart';
import 'package:waggltest/features/onboarding/presentation/bloc/qr_bloc.dart';
import 'package:waggltest/features/tasks/presentation/pages/task_page.dart';

import 'core/permissions/location_permission_handler.dart';
import 'core/routes/app_routes.dart';
import 'core/routes/route_names.dart';
import 'core/services/background_location_initializer.dart';
import 'features/onboarding/presentation/pages/qr_scan_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QrBloc>(create: (context) => QrBloc()),
        BlocProvider<WifiBloc>(
          create: (context) => WifiBloc(WifiRepositoryImpl()),
        ),
        BlocProvider<ImagePickerBloc>(
          create: (context) => ImagePickerBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // home: QrScanPage(),
        home: TaskPage(),
        // initialRoute: RouteNames.tasks,
        onGenerateRoute: AppRoutes.generate,
        // const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
