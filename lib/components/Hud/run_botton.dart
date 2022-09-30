import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'package:flame/input.dart';

class RunBotton extends HudButtonComponent {
  RunBotton({
    required button,
    buttonDown,
    EdgeInsets? margin,
    Vector2? position,
    Vector2? size,
    Anchor anchor = Anchor.center,
    onPressed,
  }) : super(
            button: button,
            buttonDown: buttonDown,
            margin: margin,
            position: position,
            size: size,
            anchor: anchor,
            onPressed: onPressed);
  bool buttonPressed = false;
  @override
  bool onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    buttonPressed = true;
    return true;
  }

  @override
  bool onTapUp(TapUpInfo info) {
    super.onTapUp(info);
    buttonPressed = false;
    return false;
  }

  @override
  bool onTapCancel() {
    // TODO: implement onTapCancel
    super.onTapCancel();
    buttonPressed = false;
    return true;
  }
}
