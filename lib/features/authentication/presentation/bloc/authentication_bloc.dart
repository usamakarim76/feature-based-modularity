import 'package:clean_architecture/core/enums/app_enums.dart';
import 'package:clean_architecture/features/authentication/domain/auth_entity.dart';
import 'package:clean_architecture/features/authentication/domain/auth_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthUseCase useCase;

  AuthenticationBloc(this.useCase) : super(AuthenticationState()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, error: null));
    try {
      final user = await useCase.signIn(event.email, event.password);
      emit(state.copyWith(status: RequestStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onRegister(
    AuthRegisterRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(status: RequestStatus.loading, error: null));
    try {
      final user = await useCase.signUp(event.email, event.password);
      emit(state.copyWith(status: RequestStatus.success, user: user));
    } catch (e) {
      emit(state.copyWith(status: RequestStatus.failure, error: e.toString()));
    }
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await useCase.signOut();
    emit(state.copyWith(status: RequestStatus.success, user: null));
  }
}
