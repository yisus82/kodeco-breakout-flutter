import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../forge2d_game_world.dart';

class Paddle extends BodyComponent<Forge2dGameWorld> {
  final Size size;
  final Vector2 position;

  Paddle({
    required this.size,
    required this.position,
  });

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.dynamic
      ..position = position
      ..fixedRotation = true
      ..angularDamping = 1.0
      ..linearDamping = 10.0;
    final paddleBody = world.createBody(bodyDef);

    final shape = PolygonShape()
      ..setAsBox(
        size.width / 2.0,
        size.height / 2.0,
        Vector2(0.0, 0.0),
        0.0,
      );
    paddleBody.createFixture(FixtureDef(shape)
      ..density = 100.0
      ..friction = 0.0
      ..restitution = 1.0);

    return paddleBody;
  }
}
