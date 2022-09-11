import 'package:flutter/animation.dart';
import 'package:retro_snake_game/constants/constants.dart';

class BigFood {
  int position = 0;
  Offset offset = Offset.zero;
  final int socre = 10;
  int count = 0;
  bool show = false;
  int time = 40;
  BigFood({
    required this.position,
    required this.offset,
  });
}

class Food {
  int position = 0;
  Offset offset = Offset.zero;
  final int socre = 5;
  int count = 0;
  Food({
    required this.position,
    required this.offset,
  });
}

class SnakeBody {
  int position = 0;
  Direction direction = Direction.right;
  Offset offset = Offset.zero;
  SnakeBody({
    required this.position,
    required this.direction,
    required this.offset,
  });
}
