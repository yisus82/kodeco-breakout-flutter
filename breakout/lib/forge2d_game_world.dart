import 'package:flame_forge2d/flame_forge2d.dart';

import 'components/ball.dart';

class Forge2dGameWorld extends Forge2DGame {
  @override
  Future<void> onLoad() async {
    await _initializeGame();
  }

  Future<void> _initializeGame() async {
    final ball = Ball(
      radius: 1.0,
      position: size / 2,
    );
    await add(ball);
  }
}
