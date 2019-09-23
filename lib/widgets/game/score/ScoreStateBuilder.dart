import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateBuilder.dart';

import 'ScoreState.dart';

class ScoreStateBuilder implements IStateBuilder {
  @override
  IState buildState() {
    // TODO: implement buildState
    return null;
  }

  @override
  IState initState() {
    ScoreState state = ScoreState();
    state.score = 0;
    state.reactionTimeAvg = 0;
    state.successes = 0;
    return state;
  }

}