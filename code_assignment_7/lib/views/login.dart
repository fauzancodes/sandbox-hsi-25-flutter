import 'package:code_assignment_7/components/custom_button.dart';
import 'package:code_assignment_7/components/custom_text.dart';
import 'package:code_assignment_7/components/custom_text_field.dart';
import 'package:code_assignment_7/components/custom_text_with_link.dart';
import 'package:code_assignment_7/pages/register.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback loginUser;

  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.loginUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 96),
              CustomText.title("Let's Login"),
              const SizedBox(height: 16),
              CustomText.subtitle("And notes your idea"),
              const SizedBox(height: 32),
              CustomTextField(
                label: "Email Address",
                placeholder: "example@mail.com",
                controller: emailController,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Password",
                placeholder: "********",
                obscureText: true,
                controller: passwordController,
              ),
              const SizedBox(height: 64),
              CustomButton(
                text: "Login",
                onPressed: loginUser,
              ),
              const SizedBox(height: 32),
              CustomTextWithLink(
                text: "Don't have any account?",
                textLink: "Register here",
                destination: const RegisterPage(),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}