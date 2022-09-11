class AssetFiles {
  static final AssetFiles _assetFiles = AssetFiles._internal();

  static String snakeImage = "assets/snake_trans.png";
  static String geekyImage = "assets/geekylogo.png";
  static String snakeThemeSong = "assets/sounds/theme_song.mp3";
  //static String snakeEatSound = "assets/sounds/key_tic.mp3";
  static String snakeEatSound = "assets/sounds/snake_food_tic.m4a";
  //static String snakeDiedSound = "assets/sounds/game_over.mp3";
  static String snakeDiedSound = "assets/sounds/snake_game_over.m4a";

  factory AssetFiles() {
    return _assetFiles;
  }
  AssetFiles._internal();
}
