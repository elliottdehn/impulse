import 'package:impulse/experiments/refactor/id/difficulty_id.dart';
import 'package:impulse/experiments/refactor/transitioner/interpreter/interpreter.dart';
import 'package:impulse/experiments/refactor/transitioner/predicator/predicator.dart';
import 'package:impulse/experiments/refactor/transitioner/transformer/transformer_builder.dart';
import 'package:impulse/state/i_notifier.dart';
import 'package:impulse/state/notifier.dart';

import '../values.dart';
import 'state_values.dart';
import 'transitioner/transformer/transformer.dart';
import 'transitioner/transitioner.dart';

class Model {
  //Singleton that can have its data cleared and reset
  static Model _singleton = Model._privateConstructor();
  static INotifier _notifierSingleton = Notifier();
  static Transitioner _transitioner;
  static StateValues _stateValues = StateValues([]);

  //this is useful for re-using tests and it is immutable
  //so I'm not worried
  StateValues get state {
    return _stateValues;
  }

  factory Model(Difficulty difficulty) {
    _transitioner = buildTransitioner(~difficulty);
    _stateValues = _transitioner.readStartState();
    return _singleton;
  }

  Model._privateConstructor();

  StateValues onEvent(Event e) {
    StateValues newState = _transitioner.transition(_stateValues, e);
    _stateValues = newState;
    _notifierSingleton.notifyListeners(_stateValues);
    return _stateValues;
  }

  StateValues readState() {
    return _stateValues;
  }

  static Transitioner buildTransitioner(DifficultyID diff) {
    Predicates predicates = Predicates();
    StatePredicator predicator = StatePredicator(predicates);

    StateTransformer transformer =
        TransformerBuilder().setDifficulty(diff).build();

    StateInterpreter interpreter = StateInterpreter();

    return Transitioner(predicator, transformer, interpreter);
  }
}
