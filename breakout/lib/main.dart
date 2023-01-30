import 'package:flutter/material.dart';

import 'ui/main_game_page.dart';

void main() {
  runApp(const BreakoutApp());
}

class BreakoutApp extends StatelessWidget {
  const BreakoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Breakout',
      home: MainGamePage(),
    );
  }
}