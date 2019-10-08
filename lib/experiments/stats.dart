import 'package:impulse/experiments/model_builder.dart';

import 'game.dart';
import 'value.dart';

class StatsModel implements IModelBuilder<Stats> {
  final GameState _gameState;
  StatsModel(this._gameState);

  Score Function() scoreF;
  AvgReaction Function() avgReactionF;
  Streak Function() streakF;
  Lives Function() livesF;

  @override
  Stats build() {
    Stats stats = new Stats(
        score: Function.apply(scoreF, []),
        avgReaction: Function.apply(avgReactionF, []),
        streak: Function.apply(streakF, []),
        lives: Function.apply(livesF, []));

    return stats;
  }

  /*
  Score
   */

  Score getScoreBasic() {
    int totalScoreFromNormals = (50 * ~_gameState.normalSymbolTotal);
    int totalScoreFromKillers = (500 * ~_gameState.killerSymbolTotal);
    return Score(totalScoreFromNormals + totalScoreFromKillers);
  }

  /*
  Avg Reaction Time
   */

  AvgReaction getAvgReactionTimeBasic() {
    int count = _gameState.reactionTimes.length;
    if (count > 0) {
      int total = 0;
      for (int reaction in _gameState.reactionTimes) {
        total += reaction;
      }
      int avg = (count / total).round();
      return AvgReaction(avg);
    }
    return AvgReaction(0);
  }

  /*
  Streak
   */

  Streak getTotalStreakBasic() {
    return Streak(_gameState.symbolStreak);
  }

  /*
  Lives
   */

  Lives getLivesBasic() {
    return Lives(~_gameState.lives);
  }
}

class Stats {
  final Score score;
  final AvgReaction avgReaction;
  final Streak streak;
  final Lives lives;

  const Stats({this.score, this.avgReaction, this.streak, this.lives});
}

class Score extends Value<int> {
  Score(int value) : super(value);
}

class AvgReaction extends Value<int> {
  AvgReaction(int value) : super(value);
}

class Streak extends Value<int> {
  Streak(int value) : super(value);
}

class Lives extends Value<int> {
  Lives(int value) : super(value);
}