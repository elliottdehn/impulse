import 'state_values.dart';
import 'test_results.dart';

abstract class Predicate {
  Predicate();
  TestResult test(StateValues sv);
}

class Predicates {
  final List<Predicate> predicates;
  Predicates(this.predicates);
  static init() {}
}

class DidPlayerReactPredicate implements Predicate {
  @override
  TestResult test(StateValues sv) {
    // TODO: implement test
    return null;
  }
}
