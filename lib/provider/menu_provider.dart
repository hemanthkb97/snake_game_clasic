import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';
import 'package:retro_snake_game/constants/assets.dart';

enum Menu { MENU, SETTINGS, LEVEL, GAME, GAMEOVER }

class MenuAndSettingsProvider extends ChangeNotifier {
  final AudioPlayer themPlayer = AudioPlayer();
  final AudioPlayer eatPlayer = AudioPlayer();
  final AudioPlayer diedPlayer = AudioPlayer();
  Menu menu = Menu.MENU;
  int level = 4;
  bool sound = true;
  bool music = false;

  MenuAndSettingsProvider() {
    initPlayers();
  }

  disposePlayers() {
    themPlayer.dispose();
    eatPlayer.dispose();
    diedPlayer.dispose();
  }

  initPlayers() async {
    try {
      await themPlayer.setAsset(AssetFiles.snakeThemeSong);
      themPlayer.setLoopMode(LoopMode.all);
      if (music) {
        themPlayer.play();
      } else {
        themPlayer.stop();
      }
    } catch (e) {
      music = false;
    }
    try {
      await eatPlayer.setAsset(AssetFiles.snakeEatSound);
      await diedPlayer.setAsset(AssetFiles.snakeDiedSound);
      eatPlayer.stop();
      diedPlayer.stop();
    } catch (e) {
      sound = false;
    }
  }

  pauseMusic() {
    if (music) {
      themPlayer.pause();
    }
  }

  playDiedPlayer() async {
    if (sound) {
      await diedPlayer.setAsset(AssetFiles.snakeDiedSound);
      diedPlayer.play();
    }
  }

  playEatSound() async {
    if (sound) {
      await eatPlayer.setAsset(AssetFiles.snakeEatSound);
      await eatPlayer.play();
    }
  }

  playMusic() {
    if (music) {
      themPlayer.play();
    }
  }

  updateLevel(int lvl) {
    if (level != lvl) {
      level = lvl;
      notifyListeners();
    }
  }

  updateMenu(Menu menu) {
    if (this.menu != menu) {
      this.menu = menu;
      notifyListeners();
    }
  }

  updateMusic() {
    music = !music;
    notifyListeners();

    if (music) {
      if (!themPlayer.playing) {
        themPlayer.play();
      }
    } else {
      if (themPlayer.playing) {
        themPlayer.stop();
      }
    }
  }

  updateSound() {
    sound = !sound;
    notifyListeners();
  }
}
