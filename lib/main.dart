import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test/core/utils/navigator_service.dart';
import 'package:flutter/material.dart';

import 'core/utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorClass.navigatorKey,
        title: 'Firebase Test',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const MyHomePage(),
        initialRoute: AppRoutes.signInScreen,
        routes: AppRoutes().routes);
  }
}
