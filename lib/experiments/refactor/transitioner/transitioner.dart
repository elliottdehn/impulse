import 'package:impulse/experiments/refactor/id/value_id.dart';

import '../../values.dart';
import 'interpreter/interpreter.dart';
import 'predicator/predicator.dart';
import 'transformer/transformer.dart';
import '../state_values.dart';

class Transitioner {
  final StatePredicator _predicator;
  final StateTransformer _transformer;
  final StateInterpreter _interpreter;

  Transitioner(this._predicator, this._transformer, this._interpreter);

  //This separation of concerns make async transitions possible
  //and increases the robustness of the application's impl
  StateValues transition(StateValues sv, Event event) {
    //this is a little pants on head but i didn't really like other solutions
    //note that this is invisibly shallow-cloning the values
    List<StateValue> shallowClone = sv.values;
    shallowClone.retainWhere((element) => element.id != ValueID.LAST_EVENT);
    shallowClone.add(EventStateValue(event));
    StateValues clonedStateNewEvent = StateValues(shallowClone);
    StateValues newValues = _interpreter.interpret(
        _transformer.transform(_predicator.test(clonedStateNewEvent)));

    newValues.add(EventStateValue(event));
    return newValues;
  }

  StateValues readStartState() {
    return _interpreter.interpret(_transformer.startState);
  }
}
