import 'package:clean_architecture/features/authentication/data/supabase_auth_service.dart';
import 'package:clean_architecture/features/authentication/domain/auth_usecase.dart';
import 'package:clean_architecture/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/auth_repository.dart';

void setupAuthDI(GetIt sl) {
  sl.registerLazySingleton(() => SupabaseAuthService(Supabase.instance.client));
  sl.registerLazySingleton(() => AuthRepository(sl<SupabaseAuthService>()));
  sl.registerLazySingleton(() => AuthUseCase(sl<AuthRepository>()));
  sl.registerFactory(() => AuthenticationBloc(sl<AuthUseCase>()));
}
