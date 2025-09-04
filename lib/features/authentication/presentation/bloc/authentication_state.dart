part of 'authentication_bloc.dart';

class AuthenticationState extends Equatable {
  final RequestStatus status;
  final AuthEntity? user;
  final String? error;

  const AuthenticationState({
    this.status = RequestStatus.idle,
    this.user,
    this.error,
  });

  AuthenticationState copyWith({
    RequestStatus? status,
    AuthEntity? user,
    String? error,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      user: user ?? this.user,
      error: error,
    );
  }

  @override
  List<Object?> get props => [status, user, error];
}
