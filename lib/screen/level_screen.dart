import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retro_snake_game/constants/constants.dart';
import 'package:retro_snake_game/provider/menu_provider.dart';
import 'package:retro_snake_game/screen/game_components/snake_and_food_ui.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key? key}) : super(key: key);

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation postionAnimation;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Level",
          style: TextStyle(
              fontFamily: "Dotted3",
              fontSize: 32,
              wordSpacing: 1,
              fontWeight: FontWeight.normal),
        ),
        const SizedBox(
          height: 16,
        ),
        Consumer<MenuAndSettingsProvider>(
          builder: (context, provider, child) {
            return Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      updateLevel(provider, 1);
                    },
                    child: Container(
                      height: 20,
                      width: 20,
                      padding: const EdgeInsets.only(bottom: 2, right: 2),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )),
                      child: Container(
                        color: provider.level == 1 ? Colors.black : null,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      updateLevel(provider, 2);
                    },
                    child: Container(
                      height: 30,
                      width: 20,
                      padding: const EdgeInsets.only(bottom: 2, right: 2),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )),
                      child: Container(
                        color: provider.level == 2 ? Colors.black : null,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      updateLevel(provider, 3);
                    },
                    child: Container(
                      height: 40,
                      width: 20,
                      padding: const EdgeInsets.only(bottom: 2, right: 2),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )),
                      child: Container(
                        color: provider.level == 3 ? Colors.black : null,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      updateLevel(provider, 4);
                    },
                    child: Container(
                      height: 50,
                      width: 20,
                      padding: const EdgeInsets.only(bottom: 2, right: 2),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )),
                      child: Container(
                        color: provider.level == 4 ? Colors.black : null,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      updateLevel(provider, 5);
                    },
                    child: Container(
                      height: 60,
                      width: 20,
                      padding: const EdgeInsets.only(bottom: 2, right: 2),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )),
                      child: Container(
                        color: provider.level == 5 ? Colors.black : null,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      updateLevel(provider, 6);
                    },
                    child: Container(
                      height: 70,
                      width: 20,
                      padding: const EdgeInsets.only(bottom: 2, right: 2),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )),
                      child: Container(
                        color: provider.level == 6 ? Colors.black : null,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      updateLevel(provider, 7);
                    },
                    child: Container(
                      height: 80,
                      width: 20,
                      padding: const EdgeInsets.only(bottom: 2, right: 2),
                      decoration: const BoxDecoration(
                          border: Border(
                        bottom: BorderSide(
                          color: Colors.black,
                        ),
                        right: BorderSide(color: Colors.black),
                      )),
                      child: Container(
                        color: provider.level == 7 ? Colors.black : null,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                height: 16,
                width: 450,
                child: Stack(
                  children: [
                    Positioned(
                      left: postionAnimation.value,
                      child: SizedBox(
                        width: 16 + 16 + 16 + 16,
                        height: 16,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [tail, normalBody, normalBody, snakeHead],
                        ),
                      ),
                    )
                  ],
                ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        InkWell(
          onTap: () {
            Provider.of<MenuAndSettingsProvider>(context, listen: false)
                .updateMenu(Menu.MENU);
          },
          child: const Text(
            "< Back",
            style: TextStyle(
                fontFamily: "Dotted3",
                fontSize: 32,
                wordSpacing: 1,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    )..repeat();
    postionAnimation = Tween<double>(begin: 0, end: 450).animate(controller);
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.duration = Duration(
          milliseconds: (speeds[Provider.of<MenuAndSettingsProvider>(context,
                          listen: false)
                      .level]! *
                  5)
              .toInt());
      controller.repeat();
    });
    super.initState();
  }

  updateLevel(MenuAndSettingsProvider provider, int lvl) {
    provider.updateLevel(lvl);
    controller.duration = Duration(milliseconds: speeds[provider.level]! * 5);
    controller.repeat();
  }
}
