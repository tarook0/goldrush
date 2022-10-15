import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/material.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:goldrush/components/Hud/hud.dart';
import 'package:goldrush/components/background.dart';
import 'package:goldrush/components/water.dart';
import 'components/character.dart';
import 'package:goldrush/components/george.dart';
import 'package:flame/components.dart';
import 'package:goldrush/components/zombie.dart';
import 'components/skeleton.dart';
import 'package:flame_audio/flame_audio.dart';
import 'dart:math';
import 'components/coin.dart';

void main() async {
  final goldRush = GoldRush();

  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(GameWidget(game: goldRush));
}

class GoldRush extends FlameGame
    with HasCollidables, HasDraggables, HasTappables {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // debugMode = true;
    FlameAudio.bgm.initialize();
    await FlameAudio.bgm.load('music/music.mp3');
    await FlameAudio.bgm.play('music/music.mp3', volume: 0.1);
    var hud = HudComponents();
    var george = George(
        position: Vector2(200, 400),
        size: Vector2(48.8, 48.0),
        speed: 90.0,
        hud: hud);

    add(george);
    add(Background(george));
    final tiledMap = await TiledComponent.load('tiles.tmx', Vector2.all(32));
    add(tiledMap);

    add(hud);

    final enemies = tiledMap.tileMap.getObjectGroupFromLayer('Enemies');
    enemies.objects.asMap().forEach((index, position) {
      if (index % 2 == 0) {
        add(Skeleton(
            position: Vector2(300, 600),
            size: Vector2(32.0, 64.0),
            speed: 60.0));
      } else {
        add(Zombie(
            position: Vector2(100, 200),
            size: Vector2(32.0, 64.0),
            speed: 20.0));
      }
    });

    Random random = Random(DateTime.now().microsecondsSinceEpoch);
    for (int i = 0; i < 50; i++) {
      int randomX = random.nextInt(48) + 1;
      int randomY = random.nextInt(48) + 1;
      double positionCoinX = (randomX * 32) + 5;
      double positionCoinY = (randomY * 32) + 5;
      add(Coin(
          position: Vector2(positionCoinX, positionCoinY),
          size: Vector2(20, 20)));
    }
    final water = tiledMap.tileMap.getObjectGroupFromLayer('Water');
    water.objects.forEach((rect) {
      add(Water(
          position: Vector2(rect.x, rect.y),
          size: Vector2(rect.width, rect.height),
          id: rect.id));
    });

    camera.speed = 1;
    camera.followComponent(george,
        worldBounds: Rect.fromLTWH(0, 0, 1600, 1600));
  }

  @override
  void onRemove() {
    FlameAudio.bgm.stop();
    FlameAudio.bgm.clearAll();
    super.onRemove();
  }

  @override
  void lifecyclesStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        children.forEach((component) {
          if (component is Character) {
            component.onPaused();
          }
        });
        break;
      case AppLifecycleState.resumed:
        children.forEach((component) {
          if (component is Character) {
            component.onResumed();
          }
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }
}
