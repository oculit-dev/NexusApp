import 'package:nexusapp/models/data_source.dart';
import 'package:nexusapp/routes.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  List list = await DataSource().getCurrentData();
  runApp(const NexusApp());
}

/// The root widget of the app.
class NexusApp extends StatelessWidget {
  /// Creates an [EquationsApp] instance.
  const NexusApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Routing setup
      onGenerateRoute: RouteGenerator.generateRoute,

      // Hiding the debug banner
      debugShowCheckedModeBanner: false,
    );
  }
}
