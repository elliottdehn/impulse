import 'dart:math';

import 'constants.dart';
import 'predicates.dart';
import 'values.dart';

enum PredicateID {
  DID_PLAYER_REACT,
  DID_FIRST_TAP,
  DID_WINDOW_CLOSE,
  DID_NEW_SYMBOL,
  IS_NORMAL_SYMBOL,
  IS_KILLER_SYMBOL,
  IS_TAPPED_ZERO,
  IS_WINDOW_OPEN,
  IS_WINDOW_CLOSING,
  IS_WINDOW_CLOSED
}

class DidPlayerReact extends TestResult {
  DidPlayerReact(x, y) : super(x, y);
}

class DidFirstTap extends TestResult {
  DidFirstTap(x, y) : super(x, y);
}

class IsNormalSymbol extends TestResult {
  IsNormalSymbol(x, y) : super(x, y);
}

class IsKillerSymbol extends TestResult {
  IsKillerSymbol(x, y) : super(x, y);
}

class IsTappedZero extends TestResult {
  IsTappedZero(x, y) : super(x, y);
}

class IsNewSymbol extends TestResult {
  IsNewSymbol(x, y) : super(x, y);
}

class IsWindowOpen extends TestResult {
  IsWindowOpen(x, y) : super(x, y);
}

class IsWindowClosing extends TestResult {
  IsWindowClosing(x, y) : super(x, y);
}

class IsWindowClosed extends TestResult {
  IsWindowClosed(x, y) : super(x, y);
}

/*
Definitions---------------------
 */

mixin Transform<T extends Transform<T>> {
  T transform(TestResults t, {T Function(TestResults, List) fn});
}

abstract class StateField<X> with Transform<StateField<X>> {
  StateField<X> transform(TestResults t,
      {StateField<X> Function(TestResults, List) fn});
}
/*
End definitions-----------------
 */

class TapCountField implements StateField<TapCountField> {
  final TapCount tc;

  TapCountField(this.tc);

  @override
  StateField<TapCountField> transform(TestResults t,
      {StateField<TapCountField> Function(TestResults, List) fn}) {
    DidPlayerReact didReact = t.get(PredicateID.DID_PLAYER_REACT);
    IsNewSymbol isNewSymbol = t.get(PredicateID.DID_NEW_SYMBOL);
    if (~didReact) {
      return new TapCountField(new TapCount(~tc + 1));
    } else if (~isNewSymbol) {
      return new TapCountField(new TapCount(0));
    } else {
      return this;
    }
  }
}

class NormalSymbolTotalField implements StateField<NormalSymbolTotalField> {
  final NormalSymbolTotal total;

  NormalSymbolTotalField(this.total);

  @override
  StateField<NormalSymbolTotalField> transform(TestResults t,
      {StateField<NormalSymbolTotalField> Function(TestResults, List) fn}) {
    bool rewardPlayer = t.and([
      PredicateID.DID_FIRST_TAP,
      PredicateID.IS_NORMAL_SYMBOL,
      PredicateID.IS_WINDOW_OPEN
    ]);
    if (rewardPlayer) {
      return NormalSymbolTotalField(NormalSymbolTotal(~total + 1));
    } else {
      return this;
    }
  }
}

class KillerSymbolTotalField implements StateField<KillerSymbolTotalField> {
  final KillerSymbolTotal total;

  KillerSymbolTotalField(this.total);

  @override
  StateField<KillerSymbolTotalField> transform(TestResults t,
      {StateField<KillerSymbolTotalField> Function(TestResults, List) fn}) {
    bool rewardPlayer = t.and([
      PredicateID.DID_NEW_SYMBOL,
      PredicateID.IS_TAPPED_ZERO,
      PredicateID.IS_KILLER_SYMBOL
    ]);
    if (rewardPlayer) {
      return KillerSymbolTotalField(new KillerSymbolTotal(~total + 1));
    } else {
      return this;
    }
  }
}

class LivesTotalField implements StateField<LivesTotalField> {
  final LivesTotal lives;

  LivesTotalField(this.lives);

  @override
  StateField<LivesTotalField> transform(TestResults t,
      {StateField<LivesTotalField> Function(TestResults, List) fn}) {
    bool playedReactedOnKiller =
        t.and([PredicateID.DID_PLAYER_REACT, PredicateID.IS_KILLER_SYMBOL]);
    bool noReactsOnNormal = t.and([
      PredicateID.IS_NORMAL_SYMBOL,
      PredicateID.IS_WINDOW_CLOSING,
      PredicateID.IS_TAPPED_ZERO
    ]);
    if (playedReactedOnKiller || noReactsOnNormal) {
      return LivesTotalField(LivesTotal(~lives - 1));
    } else {
      return this;
    }
  }
}

class ShownSymbolField implements StateField<ShownSymbol> {
  final ShownSymbol shownSymbol;

  ShownSymbolField(this.shownSymbol);

  String updateSymbolConstantOdds(
      double normalOdds, List<String> normals, List<String> killers) {
    var random = Random.secure();
    bool isNormalSymbol = random.nextDouble() <= normalOdds;
    if (isNormalSymbol) {
      return normals[random.nextInt(normals.length)];
    } else {
      return killers[random.nextInt(killers.length)];
    }
  }

  @override
  StateField<ShownSymbol> transform(TestResults t,
      {StateField<ShownSymbol> Function(TestResults, List) fn}) {
    IsNewSymbol isNewSymbol = t.get(PredicateID.DID_NEW_SYMBOL);
    if (~isNewSymbol) {
      var random = Random.secure();
      bool isNormalSymbol = random.nextDouble() <= Constants.normalOdds;
      String res;
      if (isNormalSymbol) {
        res = Constants
            .normalSymbols[random.nextInt(Constants.normalSymbols.length)];
      } else {
        res = Constants
            .killerSymbols[random.nextInt(Constants.killerSymbols.length)];
      }
      return ShownSymbolField(ShownSymbol(res));
    } else {
      return this;
    }
  }
}

class ReactionWindowStatusField implements StateField<ReactionWindowStatus> {
  final ReactionWindowStatus status;

  ReactionWindowStatusField(this.status);

  @override
  StateField<ReactionWindowStatus> transform(TestResults t,
      {StateField<ReactionWindowStatus> Function(TestResults, List) fn}) {
    bool newSymbol = ~t.get(PredicateID.DID_NEW_SYMBOL);
    bool closingOrClosed =
        t.or([PredicateID.IS_WINDOW_CLOSED, PredicateID.IS_WINDOW_CLOSING]);
    return ReactionWindowStatusField(
        ReactionWindowStatus(!closingOrClosed || newSymbol));
  }
}
