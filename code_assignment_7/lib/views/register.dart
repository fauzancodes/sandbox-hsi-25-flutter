import 'package:code_assignment_7/bloc/register/register_bloc.dart';
import 'package:code_assignment_7/bloc/register/register_event.dart';
import 'package:code_assignment_7/components/custom_button.dart';
import 'package:code_assignment_7/components/custom_text.dart';
import 'package:code_assignment_7/components/custom_text_field.dart';
import 'package:code_assignment_7/components/custom_text_with_link.dart';
import 'package:code_assignment_7/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback registerUser;

  const RegisterForm({
    super.key,
    required this.fullNameController,
    required this.emailController,
    required this.passwordController,
    required this.registerUser,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        shape: const Border(
          bottom: BorderSide(
            color: Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        title: InkWell(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: const [
              SizedBox(width: 8),
              Icon(Icons.chevron_left, color: Color(0xFF394675)),
              SizedBox(width: 4),
              Text(
                "Back",
                style: TextStyle(
                  color: Color(0xFF394675),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            CustomText.title("Register"),
            const SizedBox(height: 16),
            CustomText.subtitle("And start taking notes"),
            const SizedBox(height: 32),
            CustomTextField(
              label: "Full Name",
              placeholder: "Example: John Doe",
              controller: fullNameController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: "Email Address",
              placeholder: "Example: johndoe@gmail.com",
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
              text: "Register",
              onPressed: () {
                context.read<RegisterBloc>().add(
                      RegisterSubmitted(
                        fullName: fullNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                      ),
                    );
              },
            ),
            const SizedBox(height: 32),
            CustomTextWithLink(
              text: "Already have an account?",
              textLink: "Login here",
              destination: const LoginPage(),
            ),
          ],
        ),
      ),
    );
  }
}