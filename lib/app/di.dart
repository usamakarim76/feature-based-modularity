import 'package:get_it/get_it.dart';
// Import other services

final GetIt sl = GetIt.instance;

void setupLocator() {
  // Global dependencies
  // sl.registerLazySingleton(() => RevenueCatService());
  // sl.registerLazySingleton(() => GoogleAdsService());
  // Register other core/global services

  // Optionally, call feature-specific DI setups
  // e.g., setupAuthDI();
}
