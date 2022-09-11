import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retro_snake_game/provider/menu_provider.dart';
import 'package:retro_snake_game/screen/game_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const GameScreen(),
            ));
          },
          child: const Text(
            "New game",
            style: TextStyle(
                fontFamily: "Dotted3",
                fontSize: 32,
                wordSpacing: 1,
                fontWeight: FontWeight.normal),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            Provider.of<MenuAndSettingsProvider>(context, listen: false)
                .updateMenu(Menu.LEVEL);
          },
          child: const Text(
            "Level",
            style: TextStyle(
                fontFamily: "Dotted3",
                fontSize: 32,
                wordSpacing: 1,
                fontWeight: FontWeight.normal),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        InkWell(
          onTap: () {
            Provider.of<MenuAndSettingsProvider>(context, listen: false)
                .updateMenu(Menu.SETTINGS);
          },
          child: const Text(
            "Settings",
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
}
