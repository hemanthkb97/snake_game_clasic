class AssetFiles {
  static final AssetFiles _assetFiles = AssetFiles._internal();

  static String snakeImage = "assets/snake_trans.png";
  static String geekyImage = "assets/geekylogo.png";
  static String snakeThemeSong = "assets/sounds/theme_song.mp3";
  static String snakeEatSound = "assets/sounds/snake_food_tic.mp3";
  static String snakeDiedSound = "assets/sounds/snake_game_over.mp3";

  factory AssetFiles() {
    return _assetFiles;
  }
  AssetFiles._internal();
}
