import 'package:code_assignment_6/components/custom_button.dart';
import 'package:code_assignment_6/components/custom_text.dart';
import 'package:code_assignment_6/components/custom_text_field.dart';
import 'package:code_assignment_6/components/custom_text_with_link.dart';
import 'package:code_assignment_6/models/user.dart';
import 'package:code_assignment_6/pages/register.dart';
import 'package:code_assignment_6/pages/note_list.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _loginUser() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    var box = Hive.box<User>('users');

    User? foundUser = box.values.firstWhere(
      (user) => user.email == email && user.password == password,
      orElse: () => User(id: '', fullName: '', email: '', password: ''),
    );

    if (foundUser.email.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login successful'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const NoteListPage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid email or password'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              controller: _emailController,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              label: "Password",
              placeholder: "********",
              obscureText: true,
              controller: _passwordController,
            ),
            const SizedBox(height: 64),
            CustomButton(
              text: "Login",
              onPressed: _loginUser,
            ),
            const SizedBox(height: 32),
            CustomTextWithLink(
              text: "Don't have any account?",
              textLink: "Register here",
              destination: const RegisterPage(),
            ),
          ],
        ),
      ),
    );
  }
}
