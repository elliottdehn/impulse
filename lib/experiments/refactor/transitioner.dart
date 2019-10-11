import 'package:impulse/experiments/refactor/state_values.dart';

import 'predicate_id.dart';
import 'test_results.dart';
import '../values.dart';

abstract class Predicate<State> {
  final State _s;
  Predicate(this._s);
  TestResult test(Event e);
  PredicateID getID;
}

abstract class Predicates {
  final StateValues _s;
  Predicates(this._s);
  TestResults test(Event e);
  add(Predicate p);
}

abstract class Predicator {
  final Predicates p;
  Predicator(this.p);
  TestResults predicate(StateValues sv, Event e) {
    p.test(e);
  }
}

abstract class Transitioner {
  final Predicator predicator;
  final Transformer transformer;
  Transitioner(this.predicator, this.transformer);
  StateValues transition(StateValues sv, Event e){
    TestResults results = predicator.predicate(sv, e);
    return transformer.transform(results);
  }
}



abstract class Transformer {
  StateValues transform(TestResults tr);
}
