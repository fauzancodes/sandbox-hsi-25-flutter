import 'package:code_assignment_3/screens/title_screen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),

            const SizedBox(height: 20),

            const Text(
              'Hi! I\'m Fauzan',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                'I specialize in developing web applications with lightweight, responsive user interfaces using Next.JS and TailwindCSS, paired with high-performance, modular, and scalable APIs (REST & gRPC) using in Go or Express.JS.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TitleScreen()),
                );
              },
              child: const Text('Title Page'),
            ),
          ],
        ),
      ),
    );
  }
}