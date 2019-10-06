import 'package:impulse/experiments/model_builder.dart';
import 'package:impulse/experiments/reaction.dart';

import 'stats.dart';
import 'symbol.dart';

class GameModel implements IModelBuilder<Game>{
  static final GameModel _singleton = GameModel._privateConstructor();
  GameModel._privateConstructor();

  factory GameModel() {
    return _singleton;
  }

  final StatsModel _stats = new StatsModel(_singleton);
  final SymbolModel _symbol = new SymbolModel(_singleton);
  final ReactionModel _reaction = new ReactionModel(_singleton);

  @override
  Game build() {
    return new Game(
        symbol: _symbol.build(),
        reaction: _reaction.build(),
        stats: _stats.build());
  }

  /*
  Reaction
   */

  int baseReactionWindow = 700;

  /*
  Symbol
   */

  String shown;

  /*
  Stats
   */

  int normalSymbolTotal = 0;
  int killerSymbolTotal = 0;
  List<int> reactionTimes = List();
  int normalSymbolStreak = 0;
  int killerSymbolStreak = 0;

}

class Game {
  final Stats stats;
  final Symbol symbol;
  final Reaction reaction;

  Game({this.stats, this.symbol, this.reaction});
}
