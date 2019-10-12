import 'package:impulse/experiments/values.dart';

import 'value_id.dart';

class StateValues {
  /*
  final Event lastEvent;
  final TapCount tapCount;
  final NormalSymbolTotal normalSymbolTotal;
  final KillerSymbolTotal killerSymbolTotal;
  final ShownSymbol shownSymbol;
  final Score score;
  final IntervalLength intervalLength;
  final ReactionWindowLength reactionWindowLength;
  final ReactionWindowStatus reactionWindowStatus;
  final Lives lives;
   */

  List<StateValue> values;

  StateValues(this.values);

  get(ValueID id) {
    Map<ValueID, Value> map = Map();
  }
}

abstract class StateValue<ValueID, Value> {
  ValueID id;
  Value val;
}
