import 'package:get_it/get_it.dart';
import '../data/auth_repository.dart';

void setupAuthDI(GetIt sl) {
  sl.registerFactory(() => AuthRepository());
  // sl.registerFactory(() => AuthUseCase(sl<AuthRepository>()));
}
