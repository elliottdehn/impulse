import 'package:impulse/experiments/refactor/constants.dart';
import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/widgets/i_state_builder.dart';
import 'package:impulse/widgets/i_view_state.dart';

import 'reaction_window_state.dart';

class ReactionWindowStateBuilder implements IStateBuilder {
  @override
  IViewState buildState(StateValues s) {
    //we no longer keep track of the base window
    ReactionWindowState state = ReactionWindowState();
    state.currReactionWindow = ~s.get(ValueID.REACTION_WINDOW_LENGTH);
    state.isNormal =
        Constants.normalSymbols.contains(~s.get(ValueID.SHOWN_SYMBOL));
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
