import 'auth_entity.dart';
import '../data/auth_repository.dart';

class AuthUseCase {
  final AuthRepository repository;

  AuthUseCase(this.repository);

  Future<AuthEntity> signIn(String email, String password) =>
      repository.signIn(email, password);

  Future<AuthEntity> signUp(String email, String password) =>
      repository.signUp(email, password);

  Future<void> signOut() => repository.signOut();

  AuthEntity? get currentUser => repository.currentUser;
}
