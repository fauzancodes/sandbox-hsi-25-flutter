import 'package:code_assignment_8/service/login_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';
import '../views/login.dart';
import 'note_list.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return BlocProvider(
      create: (_) => LoginBloc(apiService: LoginApiService()),
      child: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.status == LoginStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? "Login failed"),
                backgroundColor: Colors.redAccent,
              ),
            );
          } else if (state.status == LoginStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? "Login successful"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const NoteListPage()),
            );
          }
        },
        builder: (context, state) {
          return LoginForm(
            emailController: emailController,
            passwordController: passwordController,
            loginUser: () {
              context.read<LoginBloc>().add(
                    LoginSubmitted(
                      email: emailController.text,
                      password: passwordController.text,
                    ),
                  );
            },
          );
        },
      ),
    );
  }
}
