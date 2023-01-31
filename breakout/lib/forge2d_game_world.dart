import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/extensions.dart';

import 'components/ball.dart';
import 'components/arena.dart';
import 'components/brick_wall.dart';
import 'components/paddle.dart';


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

    final brickWallPosition = Vector2(0.0, size.y * 0.075);
    final brickWall = BrickWall(
      position: brickWallPosition,
      rows: 8,
      columns: 6,
    );
    await add(brickWall);

    const paddleSize = Size(4.0, 0.8);
    final paddlePosition = Vector2(
      size.x / 2.0,
      size.y * 0.85,
    );
    final paddle = Paddle(
      size: paddleSize,
      position: paddlePosition,
    );
    await add(paddle);

    _ball = Ball(
      radius: 0.5,
      position: size / 2,
    );
    await add(_ball);
  }
}
