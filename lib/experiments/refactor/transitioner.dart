import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/widgets/EventID.dart';

import 'predicate_id.dart';
import 'state_fields.dart';
import 'test_results.dart';
import '../values.dart';

abstract class Predicate {
  Predicate();
  TestResult test(StateValues sv);
  PredicateID get id;
}

class StatePredicator {
  final Predicates ps;

  StatePredicator(this.ps);

  TestResults test(StateValues sv){
    List<Predicate> predicates = ps.predicates;
    List<TestResult> results = [];
    for(Predicate p in predicates){
      results.add(p.test(sv));
    }
    TestResults testResults = TestResults(values: results);
    return testResults;
  }
}

class Predicates {
  /*
  TODO: create the state interpreters which decide their true/falseness
   */
  final List<Predicate> predicates;

  Predicates(this.predicates);

  static init(){

  }
}

class Transitioner {
  final StatePredicator _predicator;
  final StateTransformer _transformer;
  final StateInterpreter _interpreter;

  Transitioner(this._predicator, this._transformer, this._interpreter);

  StateValues transition(StateValues sv){
    //note: lossy. This will not set the "last event" after transitioning
    //which I guess makes some kind of logical sense if you think about it.
    //I wanted it this way so it's an endo-morphic function

    //perform all necessary reads
    TestResults results = _predicator.test(sv);

    //perform all necessary writes
    StateFields newState = _transformer.transform(results);

    //separating reads from writes follow by reads
    //allows us to do all of them in an async way
    StateValues newValues = _interpreter.interpret(newState);
    return newValues;
  }
}

class StateInterpreter {
  /*
  TODO: Give fields an ID and "add" them to StateValues?
   */
  StateValues interpret(StateFields fields){
    List<StateValueField> valueFields = fields.fields;
    for(StateValueField svf in valueFields){
    }
  }
}

class StateTransformer {
  final StateFields startState;

  StateTransformer(this.startState);

  StateFields transform(TestResults results){
    //this orderless transform is the entire reason behind the refactor
    List<StateValueField> oldFields = startState.fields;
    List<StateValueField> newFields = [];
    for(StateValueField field in oldFields){
      newFields.add(field.transform(results));
    }

    StateFields newStateFields = StateFields(newFields);

    return newStateFields;
  }
}

mixin Transform<T extends Transform<T>> {
  T transform(TestResults t);
}

abstract class StateValueField<X extends Value>
    with Transform<StateValueField> {
  StateValueField<Value> transform(TestResults t);

  dynamic operator ~();
}