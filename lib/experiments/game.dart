import 'package:impulse/experiments/model_builder.dart';
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
    IModelBuilder symbolBuilder = createSymbolBuilder();
    IModelBuilder reactionBuilder = createReactionBuilder();
    IModelBuilder statsBuilder = createStatsBuilder();

    return new Game(
        symbol: symbolBuilder.build(),
        reaction: reactionBuilder.build(),
        stats: statsBuilder.build());
  }

  IModelBuilder createSymbolBuilder() {
    SymbolModel symbolBuilder = new SymbolModel(_singleton);

    symbolBuilder
      ..intervalTimeF = symbolBuilder.getIntervalConstant
      ..shownF = symbolBuilder.getShownBasic
      ..visibilityTimeF = symbolBuilder.getVisibilityTimeConstant;

    return symbolBuilder;
  }

  IModelBuilder createReactionBuilder() {
    ReactionModel reactionBuilder = new ReactionModel(_singleton);

    reactionBuilder
      ..reactionWindowF = reactionBuilder.getReactionWindowConstant
      ..baseReactionWindowF = reactionBuilder.getBaseReactionWindow
      ..isStoppedF = reactionBuilder.getIsStopped
      ..isResetF = reactionBuilder.getIsReset;

    return reactionBuilder;
  }

  IModelBuilder createStatsBuilder() {
    StatsModel statsBuilder = new StatsModel(_singleton);

    statsBuilder
      ..scoreF = statsBuilder.getScoreBasic
      ..streakF = statsBuilder.getTotalStreakBasic
      ..avgReactionF = statsBuilder.getAvgReactionTimeBasic
      ..livesF = statsBuilder.getLivesBasic;

    return statsBuilder;
  }

  int baseReactionWindow = 700;
  String shown;
  int normalSymbolTotal = 0;
  int killerSymbolTotal = 0;
  List<int> reactionTimes = List();
  int normalSymbolStreak = 0;
  int killerSymbolStreak = 0;
  int lives = 3;
}

class Game {
  final Stats stats;
  final Symbol symbol;
  final Reaction reaction;

  const Game({this.stats, this.symbol, this.reaction});
}
