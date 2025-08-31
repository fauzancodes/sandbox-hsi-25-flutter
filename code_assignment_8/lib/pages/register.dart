import 'package:code_assignment_8/service/register_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/register/register_bloc.dart';
import '../bloc/register/register_event.dart';
import '../bloc/register/register_state.dart';
import '../views/register.dart';
import 'login.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterBloc(apiService: RegisterApiService()),
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? "Registration failed"),
                backgroundColor: Colors.redAccent,
              ),
            );
          } else if (state.status == RegisterStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message ?? "Success"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          }
        },
        builder: (context, state) {
          return RegisterForm(
            nameController: TextEditingController(),
            emailController: TextEditingController(),
            passwordController: TextEditingController(),
            registerUser: () {
              final bloc = context.read<RegisterBloc>();
              bloc.add(RegisterSubmitted(
                name: bloc.state.message ?? "",
                email: bloc.state.message ?? "",
                password: bloc.state.message ?? "",
              ));
            },
          );
        },
      ),
    );
  }
}
