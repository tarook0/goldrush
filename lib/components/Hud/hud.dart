import 'package:flutter/material.dart';
import 'package:flame/components.dart';
import 'run_botton.dart';
import 'score_text.dart';
import 'joystick.dart';
import 'package:flame/palette.dart';

class HudComponents extends PositionComponent {
  HudComponents() : super(priority: 20);

  late Joystick joystick;
  late RunBotton runBotton;
  late ScoreText scoreText;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final joystickKnobPaint = BasicPalette.blue.withAlpha(200).paint();
    final joystickBackground = BasicPalette.blue.withAlpha(100).paint();
    final buttonRunPaint = BasicPalette.red.withAlpha(200).paint();
    final bottonDownRunPaint = BasicPalette.red.withAlpha(100).paint();
    joystick = Joystick(
        knob: CircleComponent(radius: 20.0, paint: joystickKnobPaint),
        background: CircleComponent(radius: 40.0, paint: joystickBackground),
        margin: const EdgeInsets.only(left: 40, bottom: 40));
    runBotton = RunBotton(
        button: CircleComponent(radius: 25.0, paint: buttonRunPaint),
        margin: const EdgeInsets.only(right: 20.0, bottom: 50.0),
        onPressed: () => {});
    scoreText = ScoreText(margin: const EdgeInsets.only(left: 40, top: 60));
    add(joystick);
    add(runBotton);
    add(scoreText);
    positionType = PositionType.viewport;
  }
}
