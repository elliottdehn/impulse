import 'package:impulse/widgets/EventID.dart';

import '../values.dart';
import 'state_values.dart';
import 'transitioner/transitioner.dart';

class Model {
  //Singleton that can have its data cleared and reset
  static Model _singleton = Model._privateConstructor();
  static Transitioner _transitioner;
  static StateValues _stateValues;

  factory Model() {
    return _singleton;
  }

  Model._privateConstructor();

  _reset() {
  }

  StateValues onEvent(Event e){
    switch(~e){
      case EventID.SELECT_DIFFICULTY_EASY:
        // TODO: Handle this case.
        break;
      case EventID.SELECT_DIFFICULTY_MEDIUM:
        // TODO: Handle this case.
        break;
      case EventID.SELECT_DIFFICULTY_HARD:
        // TODO: Handle this case.
        break;
      case EventID.SELECT_DIFFICULTY_HERO:
        // TODO: Handle this case.
        break;
      default:
        StateValues newState = _transitioner.transition(_stateValues, e);
        _stateValues = newState;
        return _stateValues;
    }
  }
}