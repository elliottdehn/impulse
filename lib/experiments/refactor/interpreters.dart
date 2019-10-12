import 'package:impulse/experiments/refactor/state_fields.dart';
import 'package:impulse/experiments/values.dart';

import 'id/field_id.dart';
import 'id/value_id.dart';
import 'state_values.dart';

class Interpreters {

  final List<Interpreter> interpreters;
  
  Interpreters(this.interpreters);

  StateValues interpret(StateFields fields){
    List<StateValue> values = [];
    //TODO Consider implementing iterable on StateFields itself
    for(Interpreter interpreter in interpreters){
      values.add(interpreter.interpret(fields));
    }

    return StateValues(values);
  }
}

abstract class Interpreter {
  StateValue<dynamic, Value> interpret(StateFields fields);
}

class TapCountInterpreter {
  StateValue<ValueID, TapCount> interpret(StateFields sf){
    TapCount tc = TapCount(~sf.get(FieldID.TAP_COUNT));
    return TapCountStateValue(tc);
  }
}


