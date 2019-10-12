import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/transitioner/transformer/state_fields.dart';

import '../../../values.dart';
import '../../state_values.dart';
import 'interpreters.dart';

class StateInterpreter {
  final List<Interpreter> interpreters = [];

  StateInterpreter() {
    interpreters.add(TapCountInterpreter());
    interpreters.add(NormalTotalInterpreter());
    interpreters.add(KillerTotalInterpreter());
    interpreters.add(LivesInterpreter());
    interpreters.add(DifficultyInterpreter());
    interpreters.add(EventInterpreter());
    interpreters.add(ShownSymbolInterpreter());
    interpreters.add(ReactionWindowLengthInterpreter());
    interpreters.add(ReactionWindowStatusInterpreter());
    interpreters.add(IntervalLengthInterpreter());
  }

  StateValues interpret(StateFields fields) {
    List<StateValue> values = [];
    for (Interpreter interpreter in interpreters) {
      values.add(interpreter.interpret(fields));
    }

    return StateValues(values);
  }
}

abstract class Interpreter<X extends StateValue<ValueID, Value>> {
  X interpret(StateFields fields);
}
