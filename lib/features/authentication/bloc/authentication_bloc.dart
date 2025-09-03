import 'package:clean_architecture/core/enums/app_enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    // Handle login event
    on<LoginRequestedEvent>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequestedEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (state is LoginState) {
      final currentState = state as LoginState;
      emit(currentState.copyWith(status: RequestStatus.loading));

      try {
        // Example: Firebase / Supabase login
        // final userId = await authRepository.login(event.email, event.password);

        emit(currentState.copyWith(status: RequestStatus.success));
      } catch (e) {
        emit(
          currentState.copyWith(
            status: RequestStatus.failure,
            errorMessage: e.toString(),
          ),
        );
      }
    }
  }
}
