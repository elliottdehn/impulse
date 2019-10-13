import 'package:impulse/experiments/refactor/transitioner/transformer/transformers.dart';
import 'package:impulse/experiments/values.dart';

import '../../id/field_id.dart';
import '../../state_values.dart';
import 'interpreter.dart';

/*
class EventInterpreter extends Interpreter<EventStateValue> {
  @override
  EventStateValue interpret(StateFields fields) {
    Event e = Event(~fields.get(FieldID.LAST_EVENT));
    return EventStateValue(e);
  }
}
*/

class DifficultyInterpreter extends Interpreter<DifficultyStateValue> {
  @override
  DifficultyStateValue interpret(StateFields fields) {
    Difficulty diff = Difficulty(~fields.get(FieldID.DIFFICULTY));
    return DifficultyStateValue(diff);
  }
}

class TapCountInterpreter extends Interpreter<TapCountStateValue> {
  TapCountStateValue interpret(StateFields sf) {
    TapCount tc = TapCount(~sf.get(FieldID.TAP_COUNT));
    return TapCountStateValue(tc);
  }
}

class NormalTotalInterpreter extends Interpreter<NormalTotalStateValue> {
  @override
  NormalTotalStateValue interpret(StateFields fields) {
    NormalSymbolTotal nt =
        NormalSymbolTotal(~fields.get(FieldID.NORMAL_SYMBOL_TOTAL));
    return NormalTotalStateValue(nt);
  }
}

class KillerTotalInterpreter extends Interpreter<KillerTotalStateValue> {
  @override
  KillerTotalStateValue interpret(StateFields fields) {
    KillerSymbolTotal kst =
        KillerSymbolTotal(~fields.get(FieldID.KILLER_SYMBOL_TOTAL));
    return KillerTotalStateValue(kst);
  }
}

class ShownSymbolInterpreter extends Interpreter<ShownSymbolStateValue> {
  @override
  ShownSymbolStateValue interpret(StateFields fields) {
    ShownSymbol ss = ShownSymbol(~fields.get(FieldID.SHOWN_SYMBOL));
    return ShownSymbolStateValue(ss);
  }
}

class ScoreInterpreter extends Interpreter<ScoreStateValue> {
  @override
  ScoreStateValue interpret(StateFields fields) {
    Score s = Score(~fields.get(FieldID.SCORE));
    return ScoreStateValue(s);
  }
}

class IntervalLengthInterpreter extends Interpreter<IntervalLengthStateValue> {
  @override
  IntervalLengthStateValue interpret(StateFields fields) {
    IntervalLength il = IntervalLength(~fields.get(FieldID.INTERVAL_LENGTH));
    return IntervalLengthStateValue(il);
  }
}

class ReactionWindowStatusInterpreter
    extends Interpreter<ReactionWindowStatusStateValue> {
  @override
  ReactionWindowStatusStateValue interpret(StateFields fields) {
    ReactionWindowStatus rws =
        ReactionWindowStatus(~fields.get(FieldID.REACTION_WINDOW_STATUS));
    return ReactionWindowStatusStateValue(rws);
  }
}

class ReactionWindowLengthInterpreter
    extends Interpreter<ReactionWindowLengthStateValue> {
  @override
  ReactionWindowLengthStateValue interpret(StateFields fields) {
    ReactionWindowLength rwl =
        ReactionWindowLength(~fields.get(FieldID.REACTION_WINDOW_LENGTH));
    return ReactionWindowLengthStateValue(rwl);
  }
}

class LivesInterpreter extends Interpreter<LivesStateValue> {
  @override
  LivesStateValue interpret(StateFields fields) {
    Lives l = Lives(~fields.get(FieldID.LIVES));
    return LivesStateValue(l);
  }
}
