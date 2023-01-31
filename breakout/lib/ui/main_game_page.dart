import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import '../forge2d_game_world.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({super.key});

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGamePage> {
  final rwGreen = const Color.fromARGB(255, 21, 132, 67);
  final forge2dGameWorld = Forge2dGameWorld();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rwGreen,
      body: Container(
        color: Colors.black87,
        margin: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 40,
        ),
        child: GameWidget(
          game: forge2dGameWorld,
        ),
      ),
    );
  }
}