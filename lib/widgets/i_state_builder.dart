import 'package:impulse/experiments/refactor/state_values.dart';

import 'i_view_state.dart';

abstract class IStateBuilder {
  IViewState initState(StateValues s);
  IViewState buildState(StateValues s);
}
