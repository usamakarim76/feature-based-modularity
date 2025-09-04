// Entry point

import 'package:clean_architecture/app/app.dart';
import 'package:clean_architecture/app/app_bloc_observer.dart';
import 'package:clean_architecture/app/di.dart';
import 'package:clean_architecture/core/services/supabase_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize services, localization, etc.
  await dotenv.load(); // Loads the .env file

  await SupabaseService.init(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  // Inject dependencies globally
  setupLocator();

  // Attach observer globally
  Bloc.observer = AppBlocObserver();

  runApp(const MyApp());
}
