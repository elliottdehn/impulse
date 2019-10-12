import 'package:impulse/experiments/refactor/constants.dart';
import 'package:impulse/widgets/EventID.dart';
//I do not like depending on event id here...

import 'state_values.dart';
import 'test_results.dart';
import 'id/value_id.dart';

abstract class Predicate<X extends TestResult> {
  Predicate();
  X test(StateValues sv);
}

class Predicates {
  final List<Predicate> predicates;
  Predicates(this.predicates);
  static init() {}
}

class DidPlayerReactPredicate implements Predicate<DidPlayerReact> {
  @override
  DidPlayerReact test(StateValues sv) {
    return DidPlayerReact(
        EventID.PLAYER_REACTED == ~sv.get(ValueID.LAST_EVENT));
  }
}

class DidFirstTapPredicate implements Predicate<DidFirstTap> {
  @override
  DidFirstTap test(StateValues sv) {
    int count = ~sv.get(ValueID.TAP_COUNT);
    bool playerReacted = ~DidPlayerReactPredicate().test(sv);
    return DidFirstTap(count == 0 && playerReacted);
  }
}

class IsWindowClosingPredicate implements Predicate<IsWindowClosing> {
  @override
  IsWindowClosing test(StateValues sv) {
    bool windowClosing = EventID.ENFORCE_TAP == ~sv.get(ValueID.LAST_EVENT);
    return IsWindowClosing(windowClosing);
  }
}

class IsWindowOpenPredicate implements Predicate<IsWindowOpen> {
  @override
  IsWindowOpen test(StateValues sv) {
    bool isWindowClosing = EventID.ENFORCE_TAP == ~sv.get(ValueID.LAST_EVENT);
    if (!isWindowClosing && ~sv.get(ValueID.REACTION_WINDOW_STATUS)) {
      return IsWindowOpen(true);
    } else {
      return IsWindowOpen(false);
    }
  }
}

class IsWindowClosedPredicate implements Predicate<IsWindowClosed> {
  @override
  IsWindowClosed test(StateValues sv) {
    if (~sv.get(ValueID.REACTION_WINDOW_STATUS) == false) {
      return IsWindowClosed(true);
    } else {
      return IsWindowClosed(false);
    }
  }
}

class IsNormalSymbolPredicate implements Predicate<IsNormalSymbol> {
  @override
  IsNormalSymbol test(StateValues sv) {
    return IsNormalSymbol(
        Constants.normalSymbols.contains(~sv.get(ValueID.SHOWN_SYMBOL)));
  }
}

class IsKillerSymbolPredicate implements Predicate<IsKillerSymbol> {
  @override
  IsKillerSymbol test(StateValues sv) {
    return IsKillerSymbol(
        Constants.killerSymbols.contains(~sv.get(ValueID.SHOWN_SYMBOL)));
  }
}

class IsTappedZeroPredicate implements Predicate<IsTappedZero> {
  @override
  IsTappedZero test(StateValues sv) {
    bool tapZero = ~sv.get(ValueID.TAP_COUNT) == 0;
    return IsTappedZero(tapZero);
  }
}

class DidNewSymbolPredicate implements Predicate<DidNewSymbol> {
  @override
  DidNewSymbol test(StateValues sv) {
    bool newSymbol = EventID.NEW_SYMBOL == ~sv.get(ValueID.LAST_EVENT);
    return DidNewSymbol(newSymbol);
  }
}
