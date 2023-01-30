import 'package:flutter/material.dart';

class MainGamePage extends StatefulWidget {
  const MainGamePage({super.key});

  @override
  MainGameState createState() => MainGameState();
}

class MainGameState extends State<MainGamePage> {
  final rwGreen = const Color.fromARGB(255, 21, 132, 67);
  // TODO: Create instance of Forge2dGameWorld here

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
        // TODO: Replace Center widget with GameWidget
        child: const Center(
          child: Text(
            'Flame Game World Goes Here!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}