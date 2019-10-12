import 'package:impulse/experiments/values.dart';

import 'id/value_id.dart';

class StateValues {
  /*
  final Event lastEvent;
  final Difficulty difficulty;
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
  
  final List<StateValue> values;

  StateValues(this.values);

  StateValue get(ValueID id) {
    values.retainWhere((element) => element.id == id);
    return values[0];
  }
}

abstract class StateValue<ValueID, X extends Value<dynamic>> {
  ValueID id;
  Value val;
  operator ~() {
    return ~val;
  }
}
