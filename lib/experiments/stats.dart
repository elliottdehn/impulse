import 'game.dart';
import 'value.dart';

class StatsModel {
  final GameModel _gameModel;
  StatsModel(this._gameModel);

  //the game model decides which strategies to use for us dynamically
  Stats getStats() {
    Stats stats = new Stats(
        score: _gameModel.score,
        avgReaction: _gameModel.avgReaction,
        streak: _gameModel.streak);

    return stats;
  }

  /*
  Score
   */

  Score getScoreBasic() {
    return Score() <<
        (50 * _gameModel.normalSymbolTotal) +
            (500 * _gameModel.killerSymbolTotal);
  }

  /*
  Avg Reaction Time
   */

  AvgReaction getAvgReactionTimeBasic() {
    int count = _gameModel.reactionTimes.length;
    if (count > 0) {
      int total = 0;
      for (int reaction in _gameModel.reactionTimes) {
        total += reaction;
      }
      int avg = (count / total).round();
      return AvgReaction() << avg;
    }
    return AvgReaction() << 0;
  }

  /*
  Streak
   */

  Streak getTotalStreakBasic() {
    return Streak() <<
        _gameModel.killerSymbolTotal + _gameModel.normalSymbolTotal;
  }
}

class Stats {
  final Score score;
  final AvgReaction avgReaction;
  final Streak streak;

  Stats({this.score, this.avgReaction, this.streak});
}

class Score with Value<int> {}

class AvgReaction with Value<int> {}

class Streak with Value<int> {}
