class GameModel {
  static final GameModel _singleton = GameModel._privateConstructor();
  GameModel._privateConstructor();

  factory GameModel() {
    return _singleton;
  }

  static final StatsModel stats = new StatsModel(_singleton);

  Stats getStats() {
    return stats.getStats();
  }

  int normalSymbolTotal = 0;
  int killerSymbolTotal = 0;
  List<int> reactionTimes = List();
  int normalSymbolStreak = 0;
  int killerSymbolStreak = 0;

  get scoreStrategy {
    return stats.getScoreBasic();
  }

  get streakStrategy {
    return stats.getTotalStreakBasic();
  }

  get avgReactionStrategy {
    return stats.getAvgReactionTimeBasic();
  }
}

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

  final Function() scoreF;
  final Function() avgReactionF;
  final Function() streakF;

  Stats(
      {this.scoreF,
      this.avgReactionF,
      this.streakF});

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

class Score with Value<int>{}
class AvgReaction with Value<int>{}
class Streak with Value<int>{}

class Value<T> {

  var value;

  T operator ~(){
    return this.value;
  }

  operator <<(T source){
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
      if(value != null) {
        return value.hashCode;
      } else {
        return 0;
      }
    }

}
