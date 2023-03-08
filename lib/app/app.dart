import 'package:flutter/material.dart';
import 'package:place_holder/presentation/resources/routes_manager.dart';
import 'package:place_holder/presentation/resources/theme_manager.dart';

class MyApp extends StatefulWidget {
  MyApp._internal();
  int appState = 0;
  static final MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}
