import 'package:clean_architecture/features/authentication/domain/auth_entity.dart';

import 'supabase_auth_service.dart';

class AuthRepository {
  final SupabaseAuthService supabaseAuthService;

  AuthRepository(this.supabaseAuthService);

  Future<AuthEntity> signIn(String email, String password) async {
    final response = await supabaseAuthService.signIn(email, password);
    if (response.user != null) {
      return AuthEntity(
        userId: response.user!.id,
        email: response.user!.email ?? "",
      );
    }
    throw Exception("Sign in failed");
  }

  Future<AuthEntity> signUp(String email, String password) async {
    final response = await supabaseAuthService.signUp(email, password);
    if (response.user != null) {
      return AuthEntity(
        userId: response.user!.id,
        email: response.user!.email ?? "",
      );
    }
    throw Exception("Sign up failed");
  }

  Future<void> signOut() async {
    await supabaseAuthService.signOut();
  }

  AuthEntity? get currentUser {
    final user = supabaseAuthService.currentUser;
    if (user != null) {
      return AuthEntity(userId: user.id, email: user.email ?? "");
    }
    return null;
  }
}
