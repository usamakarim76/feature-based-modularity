// Entry point

import 'package:clean_architecture/app/app.dart';
import 'package:clean_architecture/app/di.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize services, localization, etc.
  setupLocator(); // Inject dependencies globally

  runApp(const MyApp());
}
