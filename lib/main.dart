// Entry point

import 'package:clean_architecture/app/app.dart';
import 'package:clean_architecture/app/app_bloc_observer.dart';
import 'package:clean_architecture/app/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize services, localization, etc.

  // Inject dependencies globally
  setupLocator();

  // Attach observer globally
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}
