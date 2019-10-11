import 'package:impulse/experiments/refactor/state_values.dart';

import 'predicate_id.dart';
import 'test_results.dart';
import '../values.dart';

abstract class Predicate {
  final StateValues _s;
  Predicate(this._s);
  TestResult test(Event e);
  PredicateID getID;
}

abstract class Predicates {
  final List<Predicate> predicates;
  Predicates(this.predicates);
  TestResults test(StateValues sv);
}

abstract class Predicator {
  final Predicates p;
  Predicator(this.p);
  TestResults predicate(StateValues sv);
}

abstract class Transitioner {
  final Predicator predicator;
  final Transformer transformer;
  Transitioner(this.predicator, this.transformer);
  StateValues transition(StateValues sv);
}

abstract class Transformer {
  final Transformers ts;
  Transformer(this.ts);
  StateValues transform(TestResults tr);
}

abstract class Transformers {
  final List<Transform> transforms;
  Transformers(this.transforms);
  StateValues transform(TestResults tr);
}

mixin Transform<T extends Transform<T>> {
  T transform(TestResults t);
}

abstract class StateValueField<X extends Value>
    with Transform<StateValueField> {
  StateValueField<Value> transform(TestResults t);

  dynamic operator ~();
}
