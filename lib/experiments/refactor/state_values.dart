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

  /*
  These getters and setters are for reusing the original model tests
   */
  Value get lives {
    return get(ValueID.LIVES);
  }

  set lives(Lives lives) {
    _values.retainWhere((element) => element.id != ValueID.LIVES);
    _values.add(LivesStateValue(lives));
  }

  Value get score {
    return get(ValueID.SCORE);
  }

  set score(Score score) {
    _values.retainWhere((element) => element.id != ValueID.SCORE);
    _values.add(ScoreStateValue(score));
  }

  Value get normalSymbolTotal {
    return get(ValueID.NORMAL_SYMBOL_TOTAL);
  }

  set normalSymbolTotal(NormalSymbolTotal nst) {
    _values.retainWhere((element) => element.id != ValueID.NORMAL_SYMBOL_TOTAL);
    _values.add(NormalTotalStateValue(nst));
  }

  Value get killerSymbolTotal {
    return get(ValueID.KILLER_SYMBOL_TOTAL);
  }

  set killerSymbolTotal(KillerSymbolTotal kst) {
    _values.retainWhere((element) => element.id != ValueID.KILLER_SYMBOL_TOTAL);
    _values.add(KillerTotalStateValue(lives));
  }

  Value get tapCount {
    return get(ValueID.TAP_COUNT);
  }

  set tapCount(TapCount tapCount) {
    _values.retainWhere((element) => element.id != ValueID.TAP_COUNT);
    _values.add(TapCountStateValue(tapCount));
  }

  Value get shown {
    return get(ValueID.SHOWN_SYMBOL);
  }

  set shown(ShownSymbol symbol) {
    _values.retainWhere(((element) => element.id != ValueID.SHOWN_SYMBOL));
    _values.add(ShownSymbolStateValue(symbol));
  }

  final List<StateValue> _values;

  StateValues(this._values);

  Value get(ValueID id) {
    return ~values.firstWhere((element) => element.id == id);
  }

  List<StateValue> get values {
    //can be shallow because values (will be) internally final
    List<StateValue> shallowClone = [];
    shallowClone.addAll(_values);
    return shallowClone;
  }

  add(StateValue sv) {
    _values.add(sv);
  }
}

abstract class StateValue<ValueID, X extends Value<dynamic>> {
  final X val;

  StateValue(this.val);

  operator ~() {
    return val;
  }

  ValueID get id;
}

class EventStateValue extends StateValue<ValueID, Event> {
  EventStateValue(Event val) : super(val);

  @override
  ValueID get id {
    return ValueID.LAST_EVENT;
  }
}

class DifficultyStateValue extends StateValue<ValueID, Difficulty> {
  DifficultyStateValue(Difficulty val) : super(val);

  @override
  ValueID get id {
    return ValueID.DIFFICULTY;
  }
}

class TapCountStateValue extends StateValue<ValueID, TapCount> {
  TapCountStateValue(TapCount val) : super(val);

  @override
  ValueID get id {
    return ValueID.TAP_COUNT;
  }
}

class NormalTotalStateValue extends StateValue<ValueID, NormalSymbolTotal> {
  NormalTotalStateValue(NormalSymbolTotal val) : super(val);

  @override
  ValueID get id {
    return ValueID.NORMAL_SYMBOL_TOTAL;
  }
}

class KillerTotalStateValue extends StateValue<ValueID, KillerSymbolTotal> {
  KillerTotalStateValue(KillerSymbolTotal val) : super(val);

  @override
  ValueID get id {
    return ValueID.KILLER_SYMBOL_TOTAL;
  }
}

class ShownSymbolStateValue extends StateValue<ValueID, ShownSymbol> {
  ShownSymbolStateValue(ShownSymbol val) : super(val);

  @override
  ValueID get id {
    return ValueID.SHOWN_SYMBOL;
  }
}

class ScoreStateValue extends StateValue<ValueID, Score> {
  ScoreStateValue(Score val) : super(val);

  @override
  ValueID get id {
    return ValueID.SCORE;
  }
}

class IntervalLengthStateValue extends StateValue<ValueID, IntervalLength> {
  IntervalLengthStateValue(IntervalLength val) : super(val);

  @override
  ValueID get id {
    return ValueID.INTERVAL_LENGTH;
  }
}

class ReactionWindowStatusStateValue
    extends StateValue<ValueID, ReactionWindowStatus> {
  ReactionWindowStatusStateValue(ReactionWindowStatus val) : super(val);

  @override
  ValueID get id {
    return ValueID.REACTION_WINDOW_STATUS;
  }
}

class ReactionWindowLengthStateValue
    extends StateValue<ValueID, ReactionWindowLength> {
  ReactionWindowLengthStateValue(ReactionWindowLength val) : super(val);

  @override
  ValueID get id {
    return ValueID.REACTION_WINDOW_LENGTH;
  }
}

class LivesStateValue extends StateValue<ValueID, Lives> {
  LivesStateValue(Lives val) : super(val);

  @override
  ValueID get id {
    return ValueID.LIVES;
  }
}

class ReactionTimesStateValue extends StateValue<ValueID, ReactionTimes> {
  ReactionTimesStateValue(ReactionTimes val) : super(val);

  @override
  ValueID get id => ValueID.REACTION_TIMES;
}
