import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:retro_snake_game/constants/assets.dart';
import 'package:retro_snake_game/constants/constants.dart';
import 'package:retro_snake_game/provider/menu_provider.dart';
import 'package:retro_snake_game/screen/game_components/snake_and_food.dart';
import 'package:retro_snake_game/screen/game_components/snake_and_food_ui.dart';
import 'package:retro_snake_game/screen/welcome.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int xcount = 22, ycount = 35;
  List<SnakeBody> snakeBodys = [];
  Food food = Food(position: 0, offset: Offset.zero);
  BigFood bigFood = BigFood(position: 0, offset: Offset.zero);
  bool start = false;
  int score = 0;
  int bigFoodShowCounter = 0;
  Direction direction = Direction.right;
  List<int> totalSpot = List.generate(770, (index) => index); //totalspot
  Timer? timer;
  bool deathFlicker = false, dead = false;
  late MenuAndSettingsProvider provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// For detecting touch drag
      body: GestureDetector(
        // for checking up and down
        onVerticalDragUpdate: (details) {
          if (dead) {
            return;
          }
          if (start) {
            if (direction != Direction.up && details.delta.dy > 0) {
              if (direction != Direction.down && direction != Direction.up) {
                direction = Direction.down;
              }
            }
            if (direction != Direction.down && details.delta.dy < 0) {
              if (direction != Direction.up && direction != Direction.down) {
                direction = Direction.up;
              }
            }
          } else {
            /// If game is not started and did drag action
            /// this start the game
            startGame();
          }
        },
        // for checking left or right
        onHorizontalDragUpdate: (details) {
          if (dead) {
            return;
          }
          if (start) {
            if (direction != Direction.left && details.delta.dx > 0) {
              if (direction != Direction.right && direction != Direction.left) {
                direction = Direction.right;
              }
            }
            if (direction != Direction.right && details.delta.dx < 0) {
              if (direction != Direction.left && direction != Direction.right) {
                direction = Direction.left;
              }
            }
          } else {
            /// If game is not started and did drag action
            /// this start the game
            startGame();
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).canvasColor,
          // For listen to key events
          child: RawKeyboardListener(
            autofocus: true,
            focusNode: FocusNode(),
            // We will check which key is pressed and change direction
            // accordingly
            onKey: (value) {
              if (dead) {
                return;
              }
              if (value.isKeyPressed(LogicalKeyboardKey.escape)) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const WelcomeScreen(),
                ));
              }
              if (start) {
                if (value.isKeyPressed(LogicalKeyboardKey.arrowUp) ||
                    value.isKeyPressed(LogicalKeyboardKey.keyW)) {
                  if (direction != Direction.up &&
                      direction != Direction.down) {
                    direction = Direction.up;
                  }
                } else if (value.isKeyPressed(LogicalKeyboardKey.arrowDown) ||
                    value.isKeyPressed(LogicalKeyboardKey.keyS)) {
                  if (direction != Direction.down &&
                      direction != Direction.up) {
                    direction = Direction.down;
                  }
                } else if (value.isKeyPressed(LogicalKeyboardKey.arrowLeft) ||
                    value.isKeyPressed(LogicalKeyboardKey.keyA)) {
                  if (direction != Direction.left &&
                      direction != Direction.right) {
                    direction = Direction.left;
                  }
                } else if (value.isKeyPressed(LogicalKeyboardKey.arrowRight) ||
                    value.isKeyPressed(LogicalKeyboardKey.keyD)) {
                  if (direction != Direction.right &&
                      direction != Direction.left) {
                    direction = Direction.right;
                  }
                }
              } else if ([
                LogicalKeyboardKey.arrowUp,
                LogicalKeyboardKey.keyW,
                LogicalKeyboardKey.arrowDown,
                LogicalKeyboardKey.keyS,
                LogicalKeyboardKey.arrowLeft,
                LogicalKeyboardKey.keyA,
                LogicalKeyboardKey.arrowRight,
                LogicalKeyboardKey.keyD
              ].contains(value.logicalKey)) {
                /// If game is not started and pressed on key
                /// this start the game
                startGame();
              }
            },
            child: RepaintBoundary(
              child: Center(
                child: SizedBox(
                  width: 450,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 32,
                          ),
                          Text(
                            score.toString().padLeft(4, "0"),
                            style: const TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          if (bigFood.show)
                            Text(
                              bigFood.time.toString().padLeft(2, "0"),
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.w600),
                            ),
                          const SizedBox(
                            width: 32,
                          ),
                        ],
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                        child: Divider(
                          thickness: 4,
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            border: Border.all(
                          width: 4,
                        )),
                        child: Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 2)),
                          constraints: const BoxConstraints(
                              maxWidth: 352 + 16,
                              minWidth: 352 + 16,
                              maxHeight: 560 + 16,
                              minHeight: 560 + 16),
                          child: Center(
                            child: Stack(
                              children: [
                                ...List.generate(
                                    snakeBodys.length,
                                    (index) => Visibility(
                                          visible: !deathFlicker,
                                          replacement: const SizedBox(),
                                          child: Positioned(
                                              left: snakeBodys[index].offset.dx,
                                              top: snakeBodys[index].offset.dy,
                                              child: getSnakeBody(
                                                  snakeBodys[index],
                                                  index,
                                                  snakeBodys.length)),
                                        )),
                                Positioned(
                                    left: food.offset.dx,
                                    top: food.offset.dy,
                                    child: snakeFood),
                                if (bigFood.show)
                                  Positioned(
                                      left: bigFood.offset.dx,
                                      top: bigFood.offset.dy,
                                      child: geekyFood),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 8),
                        child: Divider(
                          thickness: 4,
                          height: 2,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 32,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: FittedBox(
                                    child: Icon(
                                      Icons.ac_unit_rounded,
                                      color: Colors.black,
                                    ),
                                  )),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                food.count.toString().padLeft(3, "0"),
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Image(
                                    image: AssetImage(AssetFiles.geekyImage),
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.none,
                                  )),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                bigFood.count.toString().padLeft(3, "0"),
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
      provider.playMusic();
    }
    if (timer != null) {
      timer!.cancel();
    }
    timer = null;
    super.dispose();
  }

  // checks weather snake eat its body
  bool gameOver() {
    final copyList = List.from(snakeBodys.map((e) => e.position)).toList();
    if (snakeBodys.length > copyList.toSet().length) {
      return true;
    } else {
      return false;
    }
  }

  /// Shows game Over alert
  gameOverAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            backgroundColor: Theme.of(context).canvasColor,
            content: Material(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Theme.of(context).canvasColor,
                padding: MediaQuery.of(context).viewPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "GAME OVER",
                      style: TextStyle(
                          fontFamily: "Dotted3",
                          fontSize: 32,
                          wordSpacing: 1,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "SCORE: ${score.toString().padLeft(4, "0")}",
                      style: const TextStyle(
                          fontFamily: "Dotted3",
                          fontSize: 24,
                          wordSpacing: 1,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                            width: 24,
                            height: 24,
                            child: FittedBox(
                              child: Icon(
                                Icons.ac_unit_rounded,
                                color: Colors.black,
                              ),
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          food.count.toString().padLeft(3, "0"),
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 24,
                            height: 24,
                            child: Image(
                              image: AssetImage(AssetFiles.geekyImage),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.none,
                            )),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          bigFood.count.toString().padLeft(3, "0"),
                          style: const TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(true);
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            color: Colors.black,
                            child: const Text(
                              "MAIN MENU",
                              style: TextStyle(
                                  fontFamily: "Dotted3",
                                  fontSize: 16,
                                  color: Colors.white,
                                  wordSpacing: 1,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop(true);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            color: Colors.black,
                            child: const Text(
                              "NEW GAME",
                              style: TextStyle(
                                  fontFamily: "Dotted3",
                                  fontSize: 16,
                                  color: Colors.white,
                                  wordSpacing: 1,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
      },
    );
    dead = false;
  }

  /// Gets Center offset for postion cell `pos` in Matrix
  Offset getOffsetforPos(int pos) {
    return Offset(
        ((pos % xcount) * 16) + 8, ((pos ~/ xcount % ycount) * 16) + 8);
  }

  /// Gets Snakebody according to the position in list and direction
  /// Snake body has head, tail and open mouth types
  Widget getSnakeBody(SnakeBody snake, int index, int length) {
    index = index + 1;
    if (index == 1) {
      return RotatedBox(
          quarterTurns: snake.direction == Direction.down
              ? 1
              : snake.direction == Direction.up
                  ? -1
                  : snake.direction == Direction.left
                      ? 2
                      : 0,
          child: tail);
    } else if (index == length) {
      return RotatedBox(
          quarterTurns: snake.direction == Direction.down
              ? 1
              : snake.direction == Direction.up
                  ? -1
                  : snake.direction == Direction.left
                      ? 2
                      : 0,
          child: openMouth(snake.position, food.position, snake.direction)
              ? eatingHead
              : snakeHead);
    } else {
      return normalBody;
    }
  }

  /// Init Board or Reset board
  /// and variables
  initBoard() {
    snakeBodys = [
      SnakeBody(
        position: 100,
        direction: Direction.right,
        offset: getOffsetforPos(100),
      ),
      SnakeBody(
        position: 101,
        direction: Direction.right,
        offset: getOffsetforPos(101),
      ),
      SnakeBody(
        position: 102,
        direction: Direction.right,
        offset: getOffsetforPos(102),
      ),
      SnakeBody(
        position: 103,
        direction: Direction.right,
        offset: getOffsetforPos(103),
      ),
      SnakeBody(
        position: 104,
        direction: Direction.right,
        offset: getOffsetforPos(104),
      ),
      SnakeBody(
        position: 105,
        direction: Direction.right,
        offset: getOffsetforPos(105),
      ),
    ];
    do {
      food.position = Random().nextInt(770);
    } while ([100, 101, 102, 103, 104, 105].contains(food.position));
    direction = Direction.right;
    deathFlicker = false;
    food.offset = getOffsetforPos(food.position);
    food.count = 0;
    bigFood.count = 0;
    bigFood.time = 40;
    totalSpot = List.generate(770, (index) => index);
    score = 0;
    bigFoodShowCounter = 0;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider = Provider.of<MenuAndSettingsProvider>(context, listen: false);
      provider.pauseMusic();
    });
    initBoard();
    super.initState();
  }

  bool openMouth(int pos, int foodPos, Direction direction) {
    int nextPos = 0;
    if (foodPos == pos) {
      return true;
    }
    switch (direction) {
      case Direction.down:
        if (pos > 748) {
          nextPos = pos - 770 + xcount;
        } else {
          nextPos = pos + xcount;
        }
        break;
      case Direction.up:
        if (pos < xcount) {
          nextPos = pos + 770 - xcount;
        } else {
          nextPos = pos - xcount;
        }
        break;
      case Direction.right:
        if ((pos + 1) % xcount == 0) {
          nextPos = pos + 1 - xcount;
        } else {
          nextPos = pos + 1;
        }
        break;
      case Direction.left:
        if (pos % xcount == 0) {
          nextPos = pos - 1 + xcount;
        } else {
          nextPos = pos - 1;
        }
        break;
      default:
    }
    if (snakeBodys.map((e) => e.position).toList().contains(nextPos)) {
      return true;
    } else {
      return nextPos == foodPos ||
          (bigFood.show && bigFood.position == nextPos);
    }
  }

  /// Starts the Snake moving
  startGame() {
    // indicates that game has started
    start = true;

    // Reset Board
    initBoard();

    // Cancel Timer if old timer is runing
    if (timer != null) {
      timer!.cancel();
      timer == null;
    }
    // Assign new timer
    timer = Timer.periodic(
        Duration(
            milliseconds: speeds[
                Provider.of<MenuAndSettingsProvider>(context, listen: false)
                    .level]!), (timer) {
      /// This will be called every duration

      // if true this will display moves counter on top Rigth
      if (bigFood.show) {
        bigFood.time -= 1;
        if (bigFood.time <= 0) {
          bigFoodShowCounter = 0;
          bigFood.show = false;
          bigFood.time = 40;
        }
      }

      // Call update snake to update to new postion
      updateSnake();

      // call gameOver
      if (gameOver()) {
        start = false;
        this.timer!.cancel();
        this.timer = null;
        int count = 0;
        provider.playDiedPlayer();
        dead = true;
        // This is for death fliker effect
        Timer.periodic(const Duration(milliseconds: 300), (timer) {
          count++;
          deathFlicker = !deathFlicker;
          setState(() {});
          if (count == 9) {
            deathFlicker = false;
            gameOverAlert();
            timer.cancel();
          }
        });
      }
    });
  }

  updateSnake() {
    /// There is no walls in this game we need to make sure snake moves through
    /// and comes from other side
    setState(() {
      switch (direction) {
        case Direction.down:
          // If Snake is already on Last Row of matrix
          // we need to make it come from top on same column
          if (snakeBodys.last.position > 748) {
            snakeBodys.add(SnakeBody(
                position: snakeBodys.last.position - 770 + xcount,
                direction: direction,
                offset:
                    getOffsetforPos(snakeBodys.last.position - 770 + xcount)));
          } else {
            // else we just move to next row of matrix
            snakeBodys.add(SnakeBody(
                position: snakeBodys.last.position + xcount,
                direction: direction,
                offset: getOffsetforPos(snakeBodys.last.position + xcount)));
          }
          break;
        case Direction.up:
          // If snake is already at the Top row of matrix
          // we need to make it come from bottom on same column
          if (snakeBodys.last.position < xcount) {
            snakeBodys.add(SnakeBody(
                position: snakeBodys.last.position + 770 - xcount,
                direction: direction,
                offset:
                    getOffsetforPos(snakeBodys.last.position + 770 - xcount)));
          } else {
            // else we just move to next row of matrix
            snakeBodys.add(SnakeBody(
                position: snakeBodys.last.position - xcount,
                direction: direction,
                offset: getOffsetforPos(snakeBodys.last.position - xcount)));
          }
          break;
        case Direction.right:
          // If snake is already at the last column of the matrix
          // we need make it come from first column the is left
          if ((snakeBodys.last.position + 1) % xcount == 0) {
            snakeBodys.add(SnakeBody(
                position: snakeBodys.last.position + 1 - xcount,
                direction: direction,
                offset:
                    getOffsetforPos(snakeBodys.last.position + 1 - xcount)));
          } else {
            snakeBodys.add(SnakeBody(
                position: snakeBodys.last.position + 1,
                direction: direction,
                offset: getOffsetforPos(snakeBodys.last.position + 1)));
          }
          break;
        case Direction.left:
          // If snake is already at the fist column of the matrix
          // we need make it come from first column the is left
          if (snakeBodys.last.position % xcount == 0) {
            snakeBodys.add(SnakeBody(
                position: snakeBodys.last.position - 1 + xcount,
                direction: direction,
                offset:
                    getOffsetforPos(snakeBodys.last.position - 1 + xcount)));
          } else {
            snakeBodys.add(SnakeBody(
                position: snakeBodys.last.position - 1,
                direction: direction,
                offset: getOffsetforPos(snakeBodys.last.position - 1)));
          }
          break;
        default:
      }
      // If the Snake last position that is head is same as Food position
      // and get new food postion
      if (snakeBodys.last.position == food.position) {
        /// Played eat sound
        provider.playEatSound();

        /// We can't have food generated on postions of the snake body
        totalSpot.removeWhere((element) =>
            snakeBodys.map((e) => e.position).toList().contains(element));

        /// get new postion for food once its eaten by snake
        food.position = totalSpot[Random().nextInt(totalSpot.length - 1)];
        food.offset = getOffsetforPos(food.position);
        // increase count
        food.count += 1;
        // Add score
        score = score + 5;
        // This to add BigFood on screen for every 5 food eaten by snake
        bigFoodShowCounter += 1;
        if (bigFoodShowCounter == 5) {
          // Then we reset this to generate again
          bigFoodShowCounter = 0;
          // we need show becs this food will disapear if not eaten within moves
          bigFood.show = true;
          do {
            bigFood.position =
                totalSpot[Random().nextInt(totalSpot.length - 1)];
          } while (food.position == bigFood.position);
          bigFood.offset = getOffsetforPos(bigFood.position);
        }

        /// This is to repopulate Total available spots to also increases randrom postions
        if (totalSpot.length < (770 / 2)) {
          totalSpot = List.generate(770, (index) => index);
        }
      }
      // We do same for bigFood also we check weather snake head that is last
      // position is same as bigFood and increase count
      else if (bigFood.show && snakeBodys.last.position == bigFood.position) {
        provider.playEatSound();
        bigFoodShowCounter = 0;
        bigFood.show = false;
        score += 20;
        bigFood.count += 1;
        bigFood.time = 40;
      } else {
        /// If Snake didn't eat any Food or BigFood we need to remove first
        /// element to keep snake lenght same
        snakeBodys.removeAt(0);
      }
    });
  }
}
