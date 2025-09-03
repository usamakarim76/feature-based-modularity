part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {}

/// Triggered when the user attempts to log in
class LoginRequestedEvent extends AuthenticationEvent {
  final String email;
  final String password;

  LoginRequestedEvent({required this.email, required this.password});
}
