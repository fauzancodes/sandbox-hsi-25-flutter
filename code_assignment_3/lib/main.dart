import 'package:code_assignment_3/screens/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profil Pengguna',
      home: const ProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
