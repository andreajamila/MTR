import 'package:flutter/material.dart';
import 'package:hulalalahanin/screens/start_game.dart';

void main() {
  runApp(Hulalalahanin());
}

class Hulalalahanin extends StatelessWidget {
  const Hulalalahanin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: StartGame(),
    );
  }
}
