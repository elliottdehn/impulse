import 'package:impulse/experiments/model_builder.dart';
import 'package:impulse/experiments/value.dart';
import 'reaction.dart';
import 'stats.dart';
import 'symbol.dart';

class GameModel implements IModelBuilder<Game> {
  static final GameModel _singleton = GameModel._privateConstructor();
  GameModel._privateConstructor();

  factory GameModel() {
    return _singleton;
  }

  @override
  Game build() {
    IModelBuilder symbolBuilder = _createSymbolBuilder();
    IModelBuilder reactionBuilder = _createReactionBuilder();
    IModelBuilder statsBuilder = _createStatsBuilder();

    return new Game(
        symbol: symbolBuilder.build(),
        reaction: reactionBuilder.build(),
        stats: statsBuilder.build());
  }

  /*
  Creators
   */

  IModelBuilder _createSymbolBuilder() {
    SymbolModel symbolBuilder = new SymbolModel(_singleton);

    symbolBuilder
      ..getIntervalTimeF = symbolBuilder.getIntervalConstant
      ..getShownF = symbolBuilder.getShown
      ..getVisibilityTimeF = symbolBuilder.getVisibilityTimeConstant;

    return symbolBuilder;
  }

  IModelBuilder _createReactionBuilder() {
    ReactionModel reactionBuilder = new ReactionModel(_singleton);

    reactionBuilder
      ..reactionWindowF = reactionBuilder.getReactionWindowConstant
      ..baseReactionWindowF = reactionBuilder.getBaseReactionWindow;

    return reactionBuilder;
  }

  IModelBuilder _createStatsBuilder() {
    StatsModel statsBuilder = new StatsModel(_singleton);

    statsBuilder
      ..scoreF = statsBuilder.getScoreBasic
      ..streakF = statsBuilder.getTotalStreakBasic
      ..avgReactionF = statsBuilder.getAvgReactionTimeBasic
      ..livesF = statsBuilder.getLivesBasic;

    return statsBuilder;
  }

  /*
  Updaters
   */

  //TODO: Implement state updates

  /*
  State
   */

  //static members are used for fields whose initial values depend on them
  static const int _startReactionWindowConst = 700; //milliseconds
  static const int _intervalFast = 1000; //milliseconds
  static const int _intervalMedium = 2000; //milliseconds
  static const int _intervalSlow = 3000; //milliseconds
  static const List<String> failureLetters = ["X"];
  static const List<String> successLetters = [
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

  final int baseReactionWindow = _startReactionWindowConst;
  final int minimumReactionWindow = 400; //milliseconds
  double reactionWindowScalar = 1.0; //multiplied to base reaction window
  int reactionWindowAdjustment = 0; //added to scaled window

  final intervalFast = _intervalFast;
  final intervalMedium = _intervalMedium;
  final intervalSlow = _intervalSlow;
  final List<int> intervals = [ //slowest -> fastest
    _intervalSlow,
    _intervalMedium,
    _intervalFast
  ];
  int minimumInterval = _startReactionWindowConst + 200; //milliseconds
  double intervalScalar = 1.0; //0.0 <-> 1.0 <-> infinity
  int intervalAdjustment = 0; //added to the final interval

  Updatable<String> shown;
  int shownTapCount = 0;
  int normalSymbolTotal = 0;
  int killerSymbolTotal = 0;
  List<int> reactionTimes = List();
  int normalSymbolStreak = 0;
  int killerSymbolStreak = 0;
  int lives = 3;
  int intervalIdx = 1;
  int visibilityTime = 125;
}

class Game {
  final Stats stats;
  final Symbol symbol;
  final Reaction reaction;

  const Game({this.stats, this.symbol, this.reaction});
}
