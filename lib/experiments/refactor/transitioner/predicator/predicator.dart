import '../../state_values.dart';
import 'test_results.dart';
import 'predicates.dart';

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

class Predicates {
  static final DidPlayerReactPredicate didPlayerReactPredicate =
      DidPlayerReactPredicate();
  static final TestSetKillerPredicate testSetKillerPredicate =
      TestSetKillerPredicate();
  static final TestSetNormalPredicate testSetNormalPredicate =
      TestSetNormalPredicate();
  static final IsWindowClosedPredicate isWindowClosedPredicate =
      IsWindowClosedPredicate();
  static final IsWindowClosingPredicate isWindowClosingPredicate =
      IsWindowClosingPredicate();
  static final IsWindowOpenPredicate isWindowOpenPredicate =
      IsWindowOpenPredicate();
  static final IsTappedZeroPredicate isTappedZeroPredicate =
      IsTappedZeroPredicate();
  static final DidFirstTapPredicate didFirstTapPredicate =
      DidFirstTapPredicate();
  static final IsKillerSymbolPredicate isKillerSymbolPredicate =
      IsKillerSymbolPredicate();
  static final IsNormalSymbolPredicate isNormalSymbolPredicate =
      IsNormalSymbolPredicate();
  static final IsEasyPredicate isEasyPredicate = IsEasyPredicate();
  static final IsMediumPredicate isMediumPredicate = IsMediumPredicate();
  static final IsHardPredicate isHardPredicate = IsHardPredicate();
  static final IsHeroPredicate isHeroPredicate = IsHeroPredicate();
  static final DidNewSymbolPredicate didNewSymbolPredicate =
      DidNewSymbolPredicate();

  final List<Predicate> predicates = [];

  Predicates() {
    predicates.add(didPlayerReactPredicate);
    predicates.add(didNewSymbolPredicate);
    predicates.add(didFirstTapPredicate);

    predicates.add(isNormalSymbolPredicate);
    predicates.add(isKillerSymbolPredicate);

    predicates.add(isWindowOpenPredicate);
    predicates.add(isWindowClosingPredicate);
    predicates.add(isWindowClosedPredicate);

    predicates.add(isTappedZeroPredicate);

    predicates.add(isEasyPredicate);
    predicates.add(isMediumPredicate);
    predicates.add(isHardPredicate);
    predicates.add(isHeroPredicate);

    predicates.add(testSetKillerPredicate);
    predicates.add(testSetNormalPredicate);
  }
}
