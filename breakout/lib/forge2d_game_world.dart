import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';

import 'components/arena.dart';
import 'components/ball.dart';
import 'components/brick_wall.dart';
import 'components/dead_zone.dart';
import 'components/paddle.dart';

enum GameState {
  initializing,
  ready,
  running,
  paused,
  won,
  lost,
}

class Forge2dGameWorld extends Forge2DGame with HasDraggables {
  late final Ball _ball;
  GameState gameState = GameState.initializing;

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

    final deadZoneSize = Size(size.x, size.y * 0.1);
    final deadZonePosition = Vector2(
      size.x / 2.0,
      size.y - (size.y * 0.1) / 2.0,
    );
    final deadZone = DeadZone(
      size: deadZoneSize,
      position: deadZonePosition,
    );
    await add(deadZone);

    const paddleSize = Size(4.0, 0.8);
    final paddlePosition = Vector2(
      size.x / 2.0,
      size.y - deadZoneSize.height - paddleSize.height / 2.0,
    );
    final paddle = Paddle(
      size: paddleSize,
      ground: arena,
      position: paddlePosition,
    );
    await add(paddle);

    _ball = Ball(
      radius: 0.5,
      position: size / 2,
    );
    await add(_ball);

    gameState = GameState.ready;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (gameState == GameState.lost) {
      pauseEngine();
    }
  }
}
