import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame/input.dart';
import 'package:flutter/cupertino.dart';

class ScoreText extends HudMarginComponent {
  ScoreText({
    EdgeInsets? margin,
  }) : super(margin: margin);

  int score = 0;
  String scoreText = "Score: ";

  late TextPaint _regulaPaint;
  late TextComponent scoreTextComponent;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    TextStyle textStyle = TextStyle(
      color: BasicPalette.green.color,
      fontSize: 30.0,
    );
    _regulaPaint = TextPaint(style: textStyle);
    scoreTextComponent = TextComponent(
        text: scoreText + score.toString(), textRenderer: _regulaPaint);
    add(scoreTextComponent);
  }

  setScore(int score) {
    this.score += score;
    scoreTextComponent.text = scoreText + this.score.toString();
  }
}
