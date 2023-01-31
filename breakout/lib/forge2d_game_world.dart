import 'package:flame_forge2d/flame_forge2d.dart';

import 'components/ball.dart';
import 'components/arena.dart';


class Forge2dGameWorld extends Forge2DGame {
  late final Ball _ball;

  Forge2dGameWorld() : super(gravity: Vector2.zero(), zoom: 20);

  @override
  Future<void> onLoad() async {
    await _initializeGame();
    _ball.body.applyLinearImpulse(Vector2(-10, -10));
  }

  Future<void> _initializeGame() async {
    final arena = Arena();
    await add(arena);

    _ball = Ball(
      radius: 0.5,
      position: size / 2,
    );
    await add(_ball);
  }
}
