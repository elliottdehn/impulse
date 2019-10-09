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

  static const int maxReactionWindowEasy = 1000; //milliseconds
  static const int maxReactionWindowMedium = 800; //milliseconds
  static const int maxReactionWindowHard = 700; //milliseconds
  static const int maxReactionWindowHero = 600; //milliseconds

  static const int _maxReactionWindowLost = 200;

  static const int minReactionWindowEasy = maxReactionWindowEasy - _maxReactionWindowLost;
  static const int minReactionWindowMedium = maxReactionWindowMedium - _maxReactionWindowLost;
  static const int minReactionWindowHard = maxReactionWindowHard - _maxReactionWindowLost;
  static const int minReactionWindowHero = maxReactionWindowHero - _maxReactionWindowLost;
}