part of 'authentication_bloc.dart';

sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

class LoginState extends AuthenticationState {
  final RequestStatus status;
  final bool isLoading;
  final String? errorMessage;

  LoginState({
    this.status = RequestStatus.idle,
    this.isLoading = false,
    this.errorMessage,
  });

  LoginState copyWith({
    RequestStatus? status,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      status: status ?? this.status,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
