import 'package:code_assignment_6/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'models/user.dart';
import 'models/note.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(NoteAdapter());

  await Hive.openBox<User>('users');
  await Hive.openBox<Note>('notes');

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
