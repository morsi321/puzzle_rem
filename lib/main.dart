import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'app/app_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([initGetIt(), _setPortraitOrientation()]);
  runApp(const MyApp());
}

Future<void> _setPortraitOrientation() async {
  final orientation = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ];
  await SystemChrome.setPreferredOrientations(orientation);
}
