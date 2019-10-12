import 'package:impulse/experiments/refactor/constants.dart';
import 'package:impulse/widgets/EventID.dart';
//I do not like depending on event id here...

import 'id/difficulty_id.dart';
import 'state_values.dart';
import 'test_results.dart';
import 'id/value_id.dart';

abstract class Predicate<X extends TestResult> {
  Predicate();
  X test(StateValues sv);
}

class Predicates {
  static final DidPlayerReactPredicate didPlayerReactPredicate =
      DidPlayerReactPredicate();
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

  final List<Predicate> predicates;
  Predicates(this.predicates);
  static Predicates init() {
    List<Predicate> predicates = [];
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

    return new Predicates(predicates);
  }
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

class IsEasyPredicate implements Predicate<IsEasy> {
  @override
  IsEasy test(StateValues sv) {
    return IsEasy(~sv.get(ValueID.DIFFICULTY) == DifficultyID.EASY);
  }
}

class IsMediumPredicate implements Predicate<IsMedium> {
  @override
  IsMedium test(StateValues sv) {
    return IsMedium(~sv.get(ValueID.DIFFICULTY) == DifficultyID.MEDIUM);
  }
}

class IsHardPredicate implements Predicate<IsHard> {
  @override
  IsHard test(StateValues sv) {
    return IsHard(~sv.get(ValueID.DIFFICULTY) == DifficultyID.HARD);
  }
}

class IsHeroPredicate implements Predicate<IsHero> {
  @override
  IsHero test(StateValues sv) {
    return IsHero(~sv.get(ValueID.DIFFICULTY) == DifficultyID.HERO);
  }
}
