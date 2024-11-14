import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_api/login/cubit/login_cubit.dart';
import 'package:flutter_login_api/login/models/models.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text("Authentication Failed"),
              ),
            );
        }
      },
      child: Align(
        alignment: Alignment(0, -1 / 3),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const InputUsername(),
              const SizedBox(height: 16),
              const InputPassword(),
              const SizedBox(height: 16),
              const ButtonSubmit(),
            ],
          ),
        ),
      ),
    );
  }
}

class InputUsername extends StatelessWidget {
  const InputUsername({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_usernameInput_textField'),
          onChanged: (value) => context.read<LoginCubit>().usernameChanged(value),
          decoration: InputDecoration(
            labelText: 'Username',
            hintText: 'Enter your username',
            errorText: state.username.displayError == UsernameValidationError.empty
                ? 'Username is required'
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        );
      },
    );
  }
}

class InputPassword extends StatelessWidget {
  const InputPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginForm_passwordInput_textField'),
          onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
          obscureText: true,
          decoration: InputDecoration(
            labelText: "Password",
            hintText: 'Enter your password',
            errorText: (() {
              switch (state.password.displayError) {
                case PasswordValidationError.minimumLength:
                  return 'Password must be at least 6 characters';
                case PasswordValidationError.empty:
                  return 'Password cannot be empty';
                default:
                  return null;
              }
            })(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        );
      },
    );
  }
}

class ButtonSubmit extends StatelessWidget {
  const ButtonSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
      return state.status.isInProgress
          ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            )
          : ElevatedButton(
              key: const Key('loginForm_continue_raisedButton'),
              onPressed: () {
                context.read<LoginCubit>().loginSubmitted();
              },
              child: const Text("Login"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 219, 221, 225),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            );
    });
  }
}
