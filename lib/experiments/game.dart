import 'package:impulse/experiments/reaction.dart';

import 'stats.dart';
import 'symbol.dart';

//Models can compose of other models but "non-models"(?) compose with non-models
class GameModel {
  static final GameModel _singleton = GameModel._privateConstructor();
  GameModel._privateConstructor();

  factory GameModel() {
    return _singleton;
  }

  final StatsModel _stats = new StatsModel(_singleton);
  final SymbolModel _symbol = new SymbolModel(_singleton);
  final ReactionModel _reaction = new ReactionModel(_singleton);

  Game get game {
    Symbol symbol = new Symbol();
    Reaction reaction = new Reaction();
    Stats stats = new Stats();
    return new Game(symbol: symbol, reaction: reaction, stats: stats);
  }

  /*
  Reaction
   */

  Reaction get reaction {
    return _reaction.reaction;
  }

  ReactionWindow get reactionWindow {
    return _reaction.getReactionWindowConstant();
  }

  BaseReactionWindow get baseReactionWindow {
    return _reaction.getBaseReactionWindow();
  }

  IsStopped get isStopped {
    return _reaction.getIsStopped();
  }

  IsReset get isReset {
    return _reaction.getIsReset();
  }

  /*
  Symbol
   */

  //Related state fields
  String shown;

  //Here, we can perform state-based logic to pick a strategy
  ShownSymbol get shownSymbol {
    return _symbol.getShownBasic();
  }

  VisibilityTime get visibilityTime {
    return _symbol.getVisibilityTimeConstant();
  }

  IntervalTime get intervalTime {
    return _symbol.getIntervalRotating();
  }

  /*
  Stats
   */

  //Related state fields
  int normalSymbolTotal = 0;
  int killerSymbolTotal = 0;
  List<int> reactionTimes = List();
  int normalSymbolStreak = 0;
  int killerSymbolStreak = 0;

  //Here, we can perform state-based logic to pick a strategy
  Score get score {
    return _stats.getScoreBasic();
  }

  Streak get streak {
    return _stats.getTotalStreakBasic();
  }

  AvgReaction get avgReaction {
    return _stats.getAvgReactionTimeBasic();
  }
}

class Game {
  final Stats stats;
  final Symbol symbol;
  final Reaction reaction;

  Game({this.stats, this.symbol, this.reaction});
}
