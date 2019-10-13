import 'package:flutter/cupertino.dart';
import 'package:impulse/experiments/refactor/id/difficulty_id.dart';
import 'package:impulse/experiments/refactor/transitioner/interpreter/interpreter.dart';
import 'package:impulse/experiments/refactor/transitioner/predicator/predicator.dart';
import 'package:impulse/experiments/refactor/transitioner/transformer/transformer_builder.dart';
import 'package:impulse/widgets/EventID.dart';

import '../values.dart';
import 'state_values.dart';
import 'transitioner/transformer/transformer.dart';
import 'transitioner/transitioner.dart';

class Model {
  //Singleton that can have its data cleared and reset
  static Model _singleton = Model._privateConstructor();
  Transitioner _transitioner;
  StateValues _stateValues = StateValues([]);

  //this is useful for re-using tests and it is immutable
  //so I'm not worried about the accessibility
  StateValues get state{
    return _stateValues;
  }

  factory Model() {
    return _singleton;
  }

  Model._privateConstructor();

  StateValues onEvent(Event e) {
    switch (~e) {
      case EventID.START_DIFFICULTY_EASY:
        _transitioner = buildTransitioner(DifficultyID.EASY);
        _stateValues = _transitioner.readStartState();
        return _stateValues;
      case EventID.START_DIFFICULTY_MEDIUM:
        _transitioner = buildTransitioner(DifficultyID.MEDIUM);
        _stateValues = _transitioner.readStartState();
        return _stateValues;
      case EventID.START_DIFFICULTY_HARD:
        _transitioner = buildTransitioner(DifficultyID.HARD);
        _stateValues = _transitioner.readStartState();
        return _stateValues;
      case EventID.START_DIFFICULTY_HERO:
        _transitioner = buildTransitioner(DifficultyID.HERO);
        _stateValues = _transitioner.readStartState();
        return _stateValues;
      default:
        StateValues newState = _transitioner.transition(_stateValues, e);
        _stateValues = newState;
        return _stateValues;
    }
  }

  Transitioner buildTransitioner(DifficultyID diff) {
    Predicates predicates = Predicates();
    StatePredicator predicator = StatePredicator(predicates);

    StateTransformer transformer =
        TransformerBuilder().setDifficulty(diff).build();

    StateInterpreter interpreter = StateInterpreter();

    return Transitioner(predicator, transformer, interpreter);
  }
}
