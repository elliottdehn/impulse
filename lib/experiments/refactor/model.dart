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
      case EventID.START_DIFFICULTY_EASY:
        _transitioner = buildTransitioner(DifficultyID.EASY);
        break;
      case EventID.START_DIFFICULTY_MEDIUM:
        _transitioner = buildTransitioner(DifficultyID.MEDIUM);
        break;
      case EventID.START_DIFFICULTY_HARD:
        _transitioner = buildTransitioner(DifficultyID.HARD);
        break;
      case EventID.START_DIFFICULTY_HERO:
        _transitioner = buildTransitioner(DifficultyID.HERO);
        break;
      default:
        StateValues newState = _transitioner.transition(_stateValues, e);
        _stateValues = newState;
        return _stateValues;
    }
  }

  Transitioner buildTransitioner(DifficultyID diff){
    Predicates preds = Predicates();
    StatePredicator predicator = StatePredicator(preds);

    StateTransformer transformer = TransformerBuilder()
        .setDifficulty(diff)
        .build();

    StateInterpreter interpreter = StateInterpreter();

    return Transitioner(predicator, transformer, interpreter);
  }
}