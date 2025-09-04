import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final String buttonLabel;
  final Function(String, String) onSubmit;
  final String? error;
  final bool isLoading;

  const AuthForm({
    super.key,
    required this.buttonLabel,
    required this.onSubmit,
    this.error,
    this.isLoading = false,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.error != null)
          Text(widget.error!, style: const TextStyle(color: Colors.red)),
        TextField(
          controller: emailController,
          decoration: const InputDecoration(labelText: 'Email'),
        ),
        TextField(
          controller: passwordController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Password'),
        ),
        const SizedBox(height: 16),
        widget.isLoading
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () {
                  widget.onSubmit(
                    emailController.text,
                    passwordController.text,
                  );
                },
                child: Text(widget.buttonLabel),
              ),
      ],
    );
  }
}
