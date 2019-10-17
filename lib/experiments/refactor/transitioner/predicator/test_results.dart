import '../../id/result_id.dart';

abstract class Tuple<X, Y> {
  final X x;
  final Y y;
  Tuple(this.x, this.y);
}

class TestResult extends Tuple<ResultID, bool> {
  TestResult(ResultID x, bool y) : super(x, y);

  bool operator &(TestResult t) {
    return this.y && t.y;
  }

  bool operator |(TestResult t) {
    return this.y || t.y;
  }

  //I know this is a little confusing
  //I just wanted to keep with the pattern of ~ being an "unwrap"
  bool operator ~() {
    return this.y;
  }
}

class TestResults {
  final Map<ResultID, bool> map = Map();

  TestResults({Iterable<TestResult> values}) {
    addAll(values);
  }

  TestResult get(ResultID id) {
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

  and(List<ResultID> predicates) {
    bool start = true;
    for (ResultID p in predicates) {
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

  or(List<ResultID> predicates) {
    bool start = false;
    for (ResultID p in predicates) {
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

class TestSetKiller extends TestResult {
  static final ResultID id = ResultID.TEST_SET_KILLER;

  TestSetKiller(bool y) : super(id, y);
}

class TestSetNormal extends TestResult {
  static final ResultID id = ResultID.TEST_SET_NORMAL;
  TestSetNormal(bool y) : super(id, y);
}

class DidPlayerReact extends TestResult {
  static final ResultID id = ResultID.DID_PLAYER_REACT;
  DidPlayerReact(y) : super(id, y);
}

class DidFirstTap extends TestResult {
  static final ResultID id = ResultID.DID_FIRST_TAP;
  DidFirstTap(y) : super(id, y);
}

class IsNormalSymbol extends TestResult {
  static final ResultID id = ResultID.IS_NORMAL_SYMBOL;
  IsNormalSymbol(y) : super(id, y);
}

class IsKillerSymbol extends TestResult {
  static final ResultID id = ResultID.IS_KILLER_SYMBOL;
  IsKillerSymbol(y) : super(id, y);
}

class IsTappedZero extends TestResult {
  static final ResultID id = ResultID.IS_TAPPED_ZERO;
  IsTappedZero(y) : super(id, y);
}

class DidNewSymbol extends TestResult {
  static final ResultID id = ResultID.DID_NEW_SYMBOL;
  DidNewSymbol(y) : super(id, y);
}

class IsWindowOpen extends TestResult {
  static final ResultID id = ResultID.IS_WINDOW_OPEN;
  IsWindowOpen(y) : super(id, y);
}

class IsWindowClosing extends TestResult {
  static final ResultID id = ResultID.IS_WINDOW_CLOSING;
  IsWindowClosing(y) : super(id, y);
}

class IsWindowClosed extends TestResult {
  static final ResultID id = ResultID.IS_WINDOW_CLOSED;
  IsWindowClosed(y) : super(id, y);
}

class IsEasy extends TestResult {
  static final ResultID id = ResultID.IS_EASY;
  IsEasy(bool y) : super(id, y);
}

class IsMedium extends TestResult {
  static final ResultID id = ResultID.IS_MEDIUM;
  IsMedium(bool y) : super(id, y);
}

class IsHard extends TestResult {
  static final ResultID id = ResultID.IS_HARD;
  IsHard(bool y) : super(id, y);
}

class IsHero extends TestResult {
  static final ResultID id = ResultID.IS_HERO;
  IsHero(bool y) : super(id, y);
}
