import 'dart:collection';

import 'state_fields.dart';
import 'values.dart';

abstract class State {}

abstract class Tuple<X, Y> {
  final X x;
  final Y y;
  Tuple(this.x, this.y);
}

class TestResult extends Tuple<PredicateID, bool> {
  TestResult(PredicateID x, bool y) : super(x, y);

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

class TestResults {
  final Map<PredicateID, bool> map = Map();

  TestResults({Iterable<TestResult> values}) {
    addAll(values);
  }

  TestResult get(PredicateID id) {
    if (map.containsKey(id)) {
      return TestResult(id, map[id]);
    } else {
      return null;
    }
  }

  add(TestResult t) {
    map.putIfAbsent(t.x, () => t.y);
  }

  addAll(List<TestResult> t) {
    for (TestResult r in t) {
      add(r);
    }
  }

  and(List<PredicateID> predicates) {
    bool start = true;
    for (PredicateID p in predicates) {
      TestResult res = get(p);
      if (res = null) {
        return false;
      } else {
        start = start && res.y;
      }
      if (!start) {
        return false;
      }
    }
    return true;
  }

  or(List<PredicateID> predicates) {
    bool start = false;
    for (PredicateID p in predicates) {
      TestResult res = get(p);
      if (res != null) {
        start = start || res.y;
      }
      if (start) {
        return true;
      }
    }
    return false;
  }
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
  add(Predicate p);
}
