class GameModel {
  static final GameModel _singleton = GameModel._privateConstructor();
  GameModel._privateConstructor();

  final StatsModel _stats = new StatsModel(_singleton);
  final SymbolModel _symbol = new SymbolModel(_singleton);

  factory GameModel() {
    return _singleton;
  }

  Game get game {
    return new Game(symbolF: _symbol.getSymbol, statsF: _stats.getStats);
  }

  /*
  Symbol
   */

  String shownSymbol;

  Function() get shownSymbolF {
    return _symbol.getShownBasic;
  }

  Function() get visibilityTimeF {
    return _symbol.getVisibilityTimeConstant;
  }

  Function() get intervalTimeF {
    return _symbol.getIntervalRotating;
  }

  /*
  Stats
   */

  int normalSymbolTotal = 0;
  int killerSymbolTotal = 0;
  List<int> reactionTimes = List();
  int normalSymbolStreak = 0;
  int killerSymbolStreak = 0;

  Function() get scoreStrategy {
    return _stats.getScoreBasic;
  }

  Function() get streakStrategy {
    return _stats.getTotalStreakBasic;
  }

  Function() get avgReactionStrategy {
    return _stats.getAvgReactionTimeBasic;
  }
}

class Game {
  final Function() statsF;
  final Function() symbolF;
  final Function() reactionF;
  final Function() livesF;

  Game({this.statsF, this.symbolF, this.reactionF, this.livesF});

  Stats get stats {
    return Function.apply(statsF, []);
  }

  Symbol get symbol {
    return Function.apply(symbolF, []);
  }
}

class SymbolModel {
  final GameModel _gameModel;
  SymbolModel(this._gameModel);

  Symbol getSymbol() {
    Symbol symbol = new Symbol(
        visibilityTimeF: _gameModel.visibilityTimeF,
        intervalTimeF: _gameModel.intervalTimeF,
        shownSymbolF: _gameModel.shownSymbolF);
    return symbol;
  }

  String getShownBasic() {
    return _gameModel.shownSymbol;
  }

  int getIntervalRotating() {
    return 3000;
  }

  int getVisibilityTimeConstant() {
    return 125;
  }
}

class Symbol {
  final Function() visibilityTimeF;
  final Function() intervalTimeF;
  final Function() shownSymbolF;

  Symbol({this.visibilityTimeF, this.intervalTimeF, this.shownSymbolF});

  VisibilityTime get visibilityTime {
    return Function.apply(visibilityTimeF, []);
  }

  IntervalTime get intervalTime {
    return Function.apply(intervalTimeF, []);
  }

  ShownSymbol get shownSymbol {
    return Function.apply(shownSymbolF, []);
  }
}

class VisibilityTime extends Value<int> {}

class IntervalTime extends Value<int> {}

class ShownSymbol extends Value<String> {}

class StatsModel {
  final GameModel _gameModel;
  StatsModel(this._gameModel);

  Stats getStats() {
    Stats stats = new Stats(
        scoreF: _gameModel.scoreStrategy,
        avgReactionF: _gameModel.avgReactionStrategy,
        streakF: _gameModel.streakStrategy);

    return stats;
  }

  /*
  Score
   */

  int getScoreBasic() {
    return (50 * _gameModel.normalSymbolTotal) +
        (500 * _gameModel.killerSymbolTotal);
  }

  /*
  Avg Reaction Time
   */

  int getAvgReactionTimeBasic() {
    int count = _gameModel.reactionTimes.length;
    if (count > 0) {
      int total = 0;
      for (int reaction in _gameModel.reactionTimes) {
        total += reaction;
      }
      int avg = (count / total).round();
      return avg;
    }
    return 0;
  }

  /*
  Streak
   */

  int getTotalStreakBasic() {
    return _gameModel.killerSymbolTotal + _gameModel.normalSymbolTotal;
  }
}

class Stats {
  final Function() scoreF; //intentionally limited to strictly no arg functions
  final Function() avgReactionF;
  final Function() streakF;

  Stats({this.scoreF, this.avgReactionF, this.streakF});

  get score {
    return new Score() << Function.apply(scoreF, []);
  }

  get avgReaction {
    return new AvgReaction() << Function.apply(avgReactionF, []);
  }

  get streak {
    return new Streak() << Function.apply(streakF, []);
  }
}

class Score with Value<int> {}

class AvgReaction with Value<int> {}

class Streak with Value<int> {}

class Value<T> {
  var value;

  T operator ~() {
    return this.value;
  }

  operator <<(T source) {
    this.value = source;
  }

  bool operator ==(Object that) {
    if (that is Value) {
      Value thatValue = that;
      return ~this == ~thatValue;
    } else {
      return false;
    }
  }

  int get hashCode {
    if (value != null) {
      return value.hashCode;
    } else {
      return 0;
    }
  }
}
