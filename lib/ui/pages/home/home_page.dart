import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Musify 🎵')),
      body: Center(child: Text('Вітаємо на головному екрані!')),
    );
  }
}
