import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:goldrush/components/background.dart';
import 'package:goldrush/components/george.dart';
import 'package:flame/components.dart';
import 'package:goldrush/components/zombie.dart';
import 'components/skeleton.dart';

void main() async {
  final goldRush = GoldRush();
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setPortrait();
  runApp(GameWidget(game: goldRush));
}

class GoldRush extends FlameGame with HasCollidables {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(Background());
    add(George(
        position: Vector2(200, 400), size: Vector2(48.8, 48.0), speed: 90.0));
    add(Zombie(
        position: Vector2(100, 200), size: Vector2(32.0, 64.0), speed: 20.0));
    add(Zombie(
        position: Vector2(300, 200), size: Vector2(32.0, 64.0), speed: 20.0));
    add(Skeleton(
        position: Vector2(100, 600), size: Vector2(32.0, 64.0), speed: 60.0));
    add(Skeleton(
        position: Vector2(300, 600), size: Vector2(32.0, 64.0), speed: 60.0));
    add(ScreenCollidable());
  }
}
