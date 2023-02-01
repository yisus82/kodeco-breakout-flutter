import 'package:flutter/material.dart';
import 'package:flame/components.dart';

import '../forge2d_game_world.dart';
import 'brick.dart';

class BrickWall extends Component with HasGameRef<Forge2dGameWorld> {
  final Vector2 position;
  final Size? size;
  final int rows;
  final int columns;
  final double gap;

  // Generate a set of colors for the bricks that span a range of colors.
  // This color generator creates a set of colors spaced across the
  // color spectrum.
  static const transparency = 1.0;
  static const saturation = 0.85;
  static const lightness = 0.5;

  List<Color> _colorSet(int count) => List<Color>.generate(
    count,
        (int index) => HSLColor.fromAHSL(
      transparency,
      index / count * 360.0,
      saturation,
      lightness,
    ).toColor(),
    growable: false,
  );

  late final List<Color> _colors;

  BrickWall({
    Vector2? position,
    this.size,
    int? rows,
    int? columns,
    double? gap,
  }) : position = position ?? Vector2.zero(),
        rows = rows ?? 1,
        columns = columns ?? 1,
        gap = gap ?? 0.1;

  Future<void> _buildWall() async {
    final wallSize = size ??
        Size(
          gameRef.size.x,
          gameRef.size.y * 0.25,
        );

    final brickSize = Size(
      ((wallSize.width - gap * 2.0) - (columns - 1) * gap) / columns,
      (wallSize.height - (rows - 1) * gap) / rows,
    );

    var brickPosition = Vector2(
      brickSize.width / 2.0 + gap,
      brickSize.height / 2.0 + position.y,
    );

    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        await add(Brick(
          size: brickSize,
          position: brickPosition,
          color: _colors[i],
        ));
        brickPosition += Vector2(brickSize.width + gap, 0.0);
      }
      brickPosition += Vector2(
        (brickSize.width / 2.0 + gap) - brickPosition.x,
        brickSize.height + gap,
      );
    }
  }

  @override
  Future<void> onLoad() async {
    _colors = _colorSet(rows);
    await _buildWall();
  }

  @override
  void update(double dt) {
    // Check for bricks in the wall that have been flagged for removal.
    // This is a destructive process so we have to iterate over a copy of
    // the elements and not the actual list of children and fixtures.
    for (final child in [...children]) {
      if (child is Brick && child.destroy) {
        for (final fixture in [...child.body.fixtures]) {
          child.body.destroyFixture(fixture);
        }
        gameRef.world.destroyBody(child.body);
        remove(child);
      }
    }
    if (children.isEmpty) {
      gameRef.gameState = GameState.won;
    }
    super.update(dt);
  }

  Future<void> reset() async {
    removeAll(children);
    await _buildWall();
  }
}
