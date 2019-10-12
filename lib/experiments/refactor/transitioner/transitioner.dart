import 'interpreter/interpreter.dart';
import 'predicator/predicator.dart';
import 'transformer/transformer.dart';
import '../state_values.dart';

class Transitioner {
  final StatePredicator _predicator;
  final StateTransformer _transformer;
  final StateInterpreter _interpreter;

  Transitioner(this._predicator, this._transformer, this._interpreter);

  StateValues transition(StateValues sv) {
    //separating reads from writes follow by reads
    //allows us to do all of them in an async way
    StateValues newValues =
        _interpreter.interpret(_transformer.transform(_predicator.test(sv)));
    return newValues;
  }
}
