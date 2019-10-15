import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/widgets/IState.dart';

import '../../StateBuilder.dart';
import 'LivesState.dart';

class LivesStateBuilder extends StateBuilder {
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
