import 'predicate_id.dart';

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
      if (res == null) {
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

/*
Impl
 */

class DidPlayerReact extends TestResult {
  static final PredicateID id = PredicateID.DID_PLAYER_REACT;
  DidPlayerReact(y) : super(id, y);
}

class DidFirstTap extends TestResult {
  static final PredicateID id = PredicateID.DID_FIRST_TAP;
  DidFirstTap(y) : super(id, y);
}

class IsNormalSymbol extends TestResult {
  static final PredicateID id = PredicateID.IS_NORMAL_SYMBOL;
  IsNormalSymbol(y) : super(id, y);
}

class IsKillerSymbol extends TestResult {
  static final PredicateID id = PredicateID.IS_KILLER_SYMBOL;
  IsKillerSymbol(y) : super(id, y);
}

class IsTappedZero extends TestResult {
  static final PredicateID id = PredicateID.IS_TAPPED_ZERO;
  IsTappedZero(y) : super(id, y);
}

class IsNewSymbol extends TestResult {
  static final PredicateID id = PredicateID.DID_NEW_SYMBOL;
  IsNewSymbol(y) : super(id, y);
}

class IsWindowOpen extends TestResult {
  static final PredicateID id = PredicateID.IS_WINDOW_OPEN;
  IsWindowOpen(y) : super(id, y);
}

class IsWindowClosing extends TestResult {
  static final PredicateID id = PredicateID.IS_WINDOW_CLOSING;
  IsWindowClosing(y) : super(id, y);
}

class IsWindowClosed extends TestResult {
  static final PredicateID id = PredicateID.IS_WINDOW_CLOSED;
  IsWindowClosed(y) : super(id, y);
}

class IsEasy extends TestResult {
  static final PredicateID id = PredicateID.IS_EASY;
  IsEasy(bool y) : super(id, y);
}

class IsMedium extends TestResult {
  static final PredicateID id = PredicateID.IS_MEDIUM;
  IsMedium(bool y) : super(id, y);
}

class IsHard extends TestResult {
  static final PredicateID id = PredicateID.IS_HARD;
  IsHard(bool y) : super(id, y);
}

class IsHero extends TestResult {
  static final PredicateID id = PredicateID.IS_HERO;
  IsHero(bool y) : super(id, y);
}
