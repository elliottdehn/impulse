import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateBuilder.dart';

import 'ScoreState.dart';

class ScoreStateBuilder implements IStateBuilder {
  @override
  IViewState buildState(StateValues s) {
    ScoreState score = ScoreState();
    score.score = ~s.get(ValueID.SCORE);
    return score;
  }

  @override
  IViewState initState(StateValues s) {
    ScoreState score = ScoreState();
    score.score = ~s.get(ValueID.SCORE);
    assert(score.score == 0);
    return score;
  }
}
