import 'package:impulse/experiments/refactor/state_values.dart';

abstract class IStateUpdateHandler {
  void onModelChanged(StateValues newState);
}
