import 'package:clean_architecture/core/enums/app_enums.dart';
import 'package:clean_architecture/core/extensions/snakbar_extension.dart';
import 'package:clean_architecture/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/auth_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state.status == RequestStatus.success) {
            context.showSuccessSnackBar('Registration Successful');
          } else if (state.status == RequestStatus.failure &&
              state.error != null) {
            context.showErrorSnackBar(state.error ?? 'An error occurred');
          }
        },
        builder: (context, state) {
          return AuthForm(
            buttonLabel: "Register",
            onSubmit: (email, password) {
              context.read<AuthenticationBloc>().add(
                AuthRegisterRequested(email: email, password: password),
              );
            },
            error: state.error,
            isLoading: state.status == RequestStatus.loading,
          );
        },
      ),
    );
  }
}
