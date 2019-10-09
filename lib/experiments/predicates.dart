import 'state_fields.dart';
import 'value.dart';
import 'values.dart';

abstract class State {}

abstract class Tuple<X, Y> {
  final dynamic x;
  final dynamic y;
  Tuple(this.x, this.y);
}

class TestResult extends Tuple<PredicateID, bool> {
  TestResult(x, y) : super(x, y);

  bool operator &(TestResult t) {
    return this.y && t.y;
  }

  bool operator |(TestResult t) {
    return this.y || t.y;
  }

  bool operator ~() {
    return this.y;
  }
}

abstract class TestResults extends Value<Map<PredicateID, bool>> {
  TestResults(Map<PredicateID, bool> value) : super(value);
  TestResult get(PredicateID id);
}

abstract class Predicate<State> {
  final State _s;
  Predicate(this._s);
  TestResult test(Event e);
  PredicateID getID;
}

abstract class Predicates {
  final State _s;
  Predicates(this._s);
  TestResults test(Event e);
}
