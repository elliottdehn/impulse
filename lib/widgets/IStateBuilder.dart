import 'package:impulse/experiments/refactor/state_values.dart';

import 'IState.dart';

abstract class IStateBuilder {
  IViewState initState(StateValues s);
  IViewState buildState(StateValues s);
}
