import 'package:flutter/material.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Title Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Fauzan',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 12),

                  Text(
                    'Fullstack Engineer',
                    style: TextStyle(fontSize: 18),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Jakarta',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 24), // Spasi antar kolom

            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.favorite,
                    color: Colors.blue,
                    size: 40,
                  ),

                  const SizedBox(height: 16),
                  
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Website'),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset(
                      'assets/images/profile.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
