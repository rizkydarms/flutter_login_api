import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_api/login/cubit/login_cubit.dart';
import 'package:flutter_login_api/login/screen/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => const LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf3f4f8),  // Light background color for a soft look
      appBar: AppBar(
        title: const Text('Login to your account', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent, // Matching app bar color
        elevation: 0,  // Removing app bar shadow for a cleaner look
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocProvider<LoginCubit>(
            create: (context) {
              return LoginCubit(
                authRepository: RepositoryProvider.of<AuthRepository>(context),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              decoration: BoxDecoration(
                color: Colors.white, // White card background for the login form
                borderRadius: BorderRadius.circular(16.0), // Rounded corners for form container
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}
