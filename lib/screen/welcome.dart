import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retro_snake_game/constants/assets.dart';
import 'package:retro_snake_game/provider/menu_provider.dart';
import 'package:retro_snake_game/screen/level_screen.dart';
import 'package:retro_snake_game/screen/menu.dart';
import 'package:retro_snake_game/screen/settings_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late MenuAndSettingsProvider menuAndSettingsProvider;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: MediaQuery.of(context).viewPadding,
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(
                  maxHeight: 600, maxWidth: 450, minHeight: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(AssetFiles.snakeImage),
                    fit: BoxFit.fitWidth,
                    width: 225,
                    height: 140,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    "---------------------------------",
                    maxLines: 1,
                    style: TextStyle(
                        fontFamily: "Dotted3",
                        fontSize: 32,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Consumer<MenuAndSettingsProvider>(
                    builder: (context, provider, child) {
                      switch (provider.menu) {
                        case Menu.MENU:
                          return const MenuScreen();
                        case Menu.LEVEL:
                          return const LevelScreen();
                        case Menu.SETTINGS:
                          return const SettingsScreen();
                        default:
                          return const MenuScreen();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (mounted) {
      menuAndSettingsProvider.disposePlayers();
    }
    super.dispose();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      menuAndSettingsProvider =
          Provider.of<MenuAndSettingsProvider>(context, listen: false);
    });
    super.initState();
  }
}
