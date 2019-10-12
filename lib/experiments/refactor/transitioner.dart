import 'predicates.dart';
import 'state_fields.dart';
import 'state_values.dart';
import 'test_results.dart';

class Transitioner {
  final StatePredicator _predicator;
  final StateTransformer _transformer;
  final StateInterpreter _interpreter;

  Transitioner(this._predicator, this._transformer, this._interpreter);

  StateValues transition(StateValues sv) {
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

class StatePredicator {
  final Predicates ps;

  StatePredicator(this.ps);

  TestResults test(StateValues sv) {
    List<Predicate> predicates = ps.predicates;
    List<TestResult> results = [];
    for (Predicate p in predicates) {
      results.add(p.test(sv));
    }
    TestResults testResults = TestResults(values: results);
    return testResults;
  }
}

class StateTransformer {
  final StateFields startState;

  StateTransformer(this.startState);

  StateFields transform(TestResults results) {
    //this orderless transform is the entire reason behind the refactor
    List<StateValueField> oldFields = startState.fields;
    List<StateValueField> newFields = [];
    for (StateValueField field in oldFields) {
      newFields.add(field.transform(results));
    }

    StateFields newStateFields = StateFields(newFields);

    return newStateFields;
  }
}

class StateInterpreter {
  /*
  TODO: Give fields an ID and "add" them to StateValues?
   */
  StateValues interpret(StateFields fields) {
    List<StateValueField> valueFields = fields.fields;
    for (StateValueField svf in valueFields) {}
  }
}
