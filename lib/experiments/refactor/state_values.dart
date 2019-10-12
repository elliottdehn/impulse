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

  Value get(ValueID id) {
    values.retainWhere((element) => element.id == id);
    return values[0].val;
  }
}

abstract class StateValue<ValueID, X extends Value<dynamic>> {
  ValueID id;
  final X val;

  StateValue(this.val);

  operator ~() {
    return ~val;
  }

  ValueID getId();

}

class EventStateValue extends StateValue<ValueID, Event>{
  EventStateValue(Event val) : super(val);

  @override
  ValueID getId() {
    return ValueID.LAST_EVENT;
  }

}

class DifficultyStateValue extends StateValue<ValueID, Difficulty>{
  DifficultyStateValue(Difficulty val) : super(val);

  @override
  ValueID getId() {
    return ValueID.DIFFICULTY;
  }

}

class TapCountStateValue extends StateValue<ValueID, TapCount>{
  TapCountStateValue(TapCount val) : super(val);

  @override
  ValueID getId() {
    return ValueID.TAP_COUNT;
  }
}

class NormalTotalStateValue extends StateValue<ValueID, NormalSymbolTotal>{
  NormalTotalStateValue(NormalSymbolTotal val) : super(val);

  @override
  ValueID getId() {
    return ValueID.NORMAL_SYMBOL_TOTAL;
  }
}

class KillerTotalStateValue extends StateValue<ValueID, KillerSymbolTotal>{
  KillerTotalStateValue(KillerSymbolTotal val) : super(val);

  @override
  ValueID getId() {
    return ValueID.KILLER_SYMBOL_TOTAL;
  }
}

class ShownSymbolStateValue extends StateValue<ValueID, ShownSymbol>{
  ShownSymbolStateValue(ShownSymbol val) : super(val);

  @override
  ValueID getId() {
    return ValueID.SHOWN_SYMBOL;
  }
}

class ScoreStateValue extends StateValue<ValueID, Score>{
  ScoreStateValue(Score val) : super(val);

  @override
  ValueID getId() {
    return ValueID.SCORE;
  }
}

class IntervalLengthStateValue extends StateValue<ValueID, IntervalLength>{
  IntervalLengthStateValue(IntervalLength val) : super(val);

  @override
  ValueID getId() {
    return ValueID.INTERVAL_LENGTH;
  }
}

class ReactionWindowStatusStateValue extends StateValue<ValueID, ReactionWindowStatus> {
  ReactionWindowStatusStateValue(ReactionWindowStatus val) : super(val);

  @override
  ValueID getId() {
    return ValueID.REACTION_WINDOW_STATUS;
  }
}

class ReactionWindowLengthStateValue extends StateValue<ValueID, ReactionWindowLength>{
  ReactionWindowLengthStateValue(ReactionWindowLength val) : super(val);

  @override
  ValueID getId() {
    return ValueID.REACTION_WINDOW_LENGTH;
  }
}

class LivesStateValue extends StateValue<ValueID, Lives>{
  LivesStateValue(Lives val) : super(val);

  @override
  ValueID getId() {
    return ValueID.LIVES;
  }
}