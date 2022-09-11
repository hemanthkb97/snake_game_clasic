import 'package:flutter/material.dart';
import 'package:retro_snake_game/constants/assets.dart';

Widget eatingHead = Container(
  decoration: const BoxDecoration(),
  width: 16,
  height: 16,
  child: Row(
    children: [
      Column(
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            transform: Matrix4.translationValues(0, -4, 0),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            transform: Matrix4.translationValues(0, 4, 0),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
        ],
      ),
    ],
  ),
);

Widget geekyFood = SizedBox(
  width: 20,
  height: 20,
  child: Image(
    image: AssetImage(AssetFiles.geekyImage),
    fit: BoxFit.cover,
    filterQuality: FilterQuality.none,
  ),
);

Widget normalBody = SizedBox(
  width: 16,
  height: 16,
  child: Row(
    children: [
      Column(
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
        ],
      ),
    ],
  ),
);
Widget snakeFood = const SizedBox(
  width: 16,
  height: 16,
  child: FittedBox(
    child: Icon(
      Icons.ac_unit_rounded,
      color: Colors.black,
    ),
  ),
);

Widget snakeHead = Container(
  decoration: const BoxDecoration(),
  width: 16,
  height: 16,
  child: Row(
    children: [
      Column(
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            transform: Matrix4.translationValues(0, -6, 0),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
        ],
      ),
      Column(
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
        ],
      ),
    ],
  ),
);

Widget tail = SizedBox(
  width: 16,
  height: 16,
  child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Container(
        width: 6,
        height: 6,
        margin: const EdgeInsets.all(1),
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
      ),
      Column(
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.all(1),
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
        ],
      ),
    ],
  ),
);
