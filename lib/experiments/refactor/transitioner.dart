import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/widgets/EventID.dart';

import 'predicate_id.dart';
import 'test_results.dart';
import '../values.dart';

abstract class Predicate {
  final StateValues _s;
  Predicate(this._s);
  TestResult test(Event e);
  PredicateID get id;
}

abstract class Predicates {
  final List<Predicate> predicates;
  Predicates(this.predicates);
  TestResults test(StateValues sv);
}

mixin Transform<T extends Transform<T>> {
  T transform(TestResults t);
}

abstract class StateValueField<X extends Value>
    with Transform<StateValueField> {
  StateValueField<Value> transform(TestResults t);

  dynamic operator ~();
}