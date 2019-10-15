import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/StateBuilder.dart';

import 'ReactionWindowState.dart';

class ReactionWindowStateBuilder extends StateBuilder {

  @override
  IViewState buildState(StateValues s) {
    //we no longer keep track of the base window
    ReactionWindowState state = ReactionWindowState();
    state.currReactionWindow = ~s.get(ValueID.REACTION_WINDOW_LENGTH);
    return state;
  }

  @override
  IViewState initState(StateValues s) {
    ReactionWindowState state = ReactionWindowState();
    int initialWindowLength = ~s.get(ValueID.REACTION_WINDOW_LENGTH);
    state.baseReactionWindow = initialWindowLength;
    state.currReactionWindow = initialWindowLength;
    state.isStopped = false;
    state.isReset = false;
    return state;
  }

}