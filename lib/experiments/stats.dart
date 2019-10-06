import 'package:impulse/experiments/model_builder.dart';

import 'game.dart';
import 'value.dart';

class StatsModel implements IModelBuilder<Stats> {
  final GameModel _gameModel;
  StatsModel(this._gameModel);

  @override
  Stats build() {
    Stats stats = new Stats(
        score: getScoreBasic(),
        avgReaction: getAvgReactionTimeBasic(),
        streak: getTotalStreakBasic());

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
