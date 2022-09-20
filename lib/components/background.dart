import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flame/palette.dart';
import 'dart:ui';

class Background extends PositionComponent {
  static final backgroundPaint = BasicPalette.magenta.paint();
  late double screenWidth, screenHeight;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    screenWidth = MediaQueryData.fromWindow(window).size.width;
    screenHeight = MediaQueryData.fromWindow(window).size.height;
    position = Vector2(0, 0);
    size = Vector2(screenWidth, screenHeight);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    canvas.drawRect(
        Rect.fromPoints(position.toOffset(), size.toOffset()), backgroundPaint);
  }
}
