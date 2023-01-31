import 'package:flame_forge2d/flame_forge2d.dart';

import '../forge2d_game_world.dart';

class Ball extends BodyComponent<Forge2dGameWorld> {
  final Vector2 position;
  final double radius;

  Ball({required this.position, required this.radius});

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.dynamic
      ..position = position;
    final ball = world.createBody(bodyDef);
    final shape = CircleShape()..radius = radius;

    final fixtureDef = FixtureDef(shape)
      ..restitution = 1.0
      ..density = 1.0;
    ball.createFixture(fixtureDef);

    return ball;
  }
}
