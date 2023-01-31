import 'package:flame/extensions.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import '../forge2d_game_world.dart';
import 'ball.dart';

class DeadZone extends BodyComponent<Forge2dGameWorld> with ContactCallbacks {
  final Size size;
  final Vector2 position;

  DeadZone({
    required this.size,
    required this.position,
  });

  @override
  bool get renderBody => false;

  @override
  Body createBody() {
    final bodyDef = BodyDef()
      ..type = BodyType.static
      ..userData = this
      ..position = position;
    final zoneBody = world.createBody(bodyDef);

    final shape = PolygonShape()
      ..setAsBox(
        size.width / 2.0,
        size.height / 2.0,
        Vector2.zero(),
        0.0,
      );
    zoneBody.createFixture(FixtureDef(shape)..isSensor = true);

    return zoneBody;
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ball) {
      gameRef.gameState = GameState.lost;
    }
  }
}
