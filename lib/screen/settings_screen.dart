import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:retro_snake_game/provider/menu_provider.dart';
import 'package:retro_snake_game/provider/theme_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Text(
            "Settings",
            style: TextStyle(
                fontFamily: "Dotted3",
                fontSize: 32,
                wordSpacing: 1,
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 40,
          ),
          Consumer<MenuAndSettingsProvider>(
            builder: (context, provider, child) {
              return Row(
                children: [
                  const Expanded(
                    flex: 4,
                    child: Text(
                      "Sound",
                      style: TextStyle(
                          fontFamily: "Dotted3",
                          fontSize: 28,
                          wordSpacing: 1,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      provider.updateSound();
                    },
                    child: Text(
                      provider.sound ? "ON" : "OFF",
                      style: const TextStyle(
                          fontFamily: "Dotted3",
                          fontSize: 28,
                          wordSpacing: 1,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
          Consumer<MenuAndSettingsProvider>(
            builder: (context, provider, child) {
              return Row(
                children: [
                  const Expanded(
                    flex: 4,
                    child: Text(
                      "Music",
                      style: TextStyle(
                          fontFamily: "Dotted3",
                          fontSize: 28,
                          wordSpacing: 1,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      provider.updateMusic();
                    },
                    child: Text(
                      provider.music ? "ON" : "OFF",
                      style: const TextStyle(
                          fontFamily: "Dotted3",
                          fontSize: 28,
                          wordSpacing: 1,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 40,
          ),
          Consumer<ThemeModeProvider>(
            builder: (context, provider, child) {
              return Row(
                children: [
                  const Expanded(
                    flex: 4,
                    child: Text(
                      "Light",
                      style: TextStyle(
                          fontFamily: "Dotted3",
                          fontSize: 28,
                          wordSpacing: 1,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      provider.switchTheme();
                    },
                    child: Text(
                      provider.themeMode == ThemeMode.light ? "ON" : "OFF",
                      style: const TextStyle(
                          fontFamily: "Dotted3",
                          fontSize: 28,
                          wordSpacing: 1,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 40,
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
      ),
    );
  }
}
