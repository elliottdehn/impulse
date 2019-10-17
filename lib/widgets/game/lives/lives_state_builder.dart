import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/widgets/i_state_builder.dart';
import 'package:impulse/widgets/i_view_state.dart';

import 'lives_state.dart';

class LivesStateBuilder implements IStateBuilder {
  @override
  IViewState buildState(StateValues s) {
    LivesState ls = LivesState();
    ls.lives = ~s.get(ValueID.LIVES);
    return ls;
  }

  @override
  IViewState initState(StateValues s) {
    LivesState ls = LivesState();
    ls.lives = ~s.get(ValueID.LIVES);
    return ls;
  }
}
