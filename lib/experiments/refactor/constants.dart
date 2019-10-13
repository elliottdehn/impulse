import 'dart:math';

class Constants {
  static const List<String> killerSymbols = ["X"];
  static const List<String> normalSymbols = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "Y",
    "Z"
  ];

  static const double normalOdds = 0.8;

  static const int intervalFast = 1000; //milliseconds
  static const int intervalMedium = 2000; //milliseconds
  static const int intervalSlow = 3000; //milliseconds
  static const List<int> intervals = [
    intervalSlow,
    intervalMedium,
    intervalFast
  ];

  static const int _maxReactionWindowLost = 200;

  static const int maxReactionWindowEasy = 1000; //milliseconds
  static const int maxReactionWindowMedium = 800; //milliseconds
  static const int maxReactionWindowHard = 700; //milliseconds
  static const int maxReactionWindowHero = 600; //milliseconds

  static const int minReactionWindowEasy =
      maxReactionWindowEasy - _maxReactionWindowLost;
  static const int minReactionWindowMedium =
      maxReactionWindowMedium - _maxReactionWindowLost;
  static const int minReactionWindowHard =
      maxReactionWindowHard - _maxReactionWindowLost;
  static const int minReactionWindowHero =
      maxReactionWindowHero - _maxReactionWindowLost;

  static const int reactionWindowAdjEasy = -2;
  static const int reactionWindowAdjMedium = -3;
  static const int reactionWindowAdjHard = -4;
  static const int reactionWindowAdjHero = -5;
  static const int _randomSeedMax = 247383920;
  static final randomRandomSeed = Random().nextInt(_randomSeedMax);

  static const double easyScoreMultiplier = 0.5;
  static const double mediumScoreMultiplier = easyScoreMultiplier * 3;
  static const double hardScoreMultiplier = mediumScoreMultiplier * 3;
  static const double heroScoreMultiplier = hardScoreMultiplier * 3;

  static const int livesStartEasy = 6;
  static const int livesStartMedium = 5;
  static const int livesStartHard = 4;
  static const int livesStartHero = 3;
}
