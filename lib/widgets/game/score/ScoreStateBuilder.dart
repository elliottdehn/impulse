import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/score/ScoreOracle.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateBuilder.dart';

import 'ScoreState.dart';

class ScoreStateBuilder implements IStateBuilder {

  IOracle score = ScoreOracle();

  @override
  IState buildState() {
    return score.getAnswer();
  }

  @override
  IState initState() {
    ScoreState state = ScoreState();
    state.score = 0;
    return state;
  }
}
