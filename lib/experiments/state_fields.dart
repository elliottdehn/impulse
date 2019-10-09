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
  IS_WINDOW_CLOSED,
  IS_EASY,
  IS_MEDIUM,
  IS_HARD,
  IS_HERO,
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
  T transform(TestResults t);
}

abstract class StateValueField<X extends Value>
    with Transform<StateValueField> {
  StateValueField<Value> transform(TestResults t);

  X operator ~();
}
/*
End definitions-----------------
 */

class TapCountField implements StateValueField<TapCount> {
  final TapCount tc;

  TapCountField(this.tc);

  @override
  StateValueField<TapCount> transform(TestResults t) {
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

  @override
  TapCount operator ~() {
    return tc;
  }
}

class NormalSymbolTotalField implements StateValueField<NormalSymbolTotal> {
  final NormalSymbolTotal total;

  NormalSymbolTotalField(this.total);

  @override
  StateValueField<NormalSymbolTotal> transform(TestResults t) {
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

  @override
  NormalSymbolTotal operator ~() {
    return total;
  }
}

class KillerSymbolTotalField implements StateValueField<KillerSymbolTotal> {
  final KillerSymbolTotal total;

  KillerSymbolTotalField(this.total);

  @override
  StateValueField<KillerSymbolTotal> transform(TestResults t) {
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

  @override
  KillerSymbolTotal operator ~() {
    return total;
  }
}

class LivesTotalField implements StateValueField<LivesTotal> {
  final LivesTotal lives;

  LivesTotalField(this.lives);

  @override
  StateValueField<LivesTotal> transform(TestResults t) {
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

  @override
  LivesTotal operator ~() {
    return lives;
  }
}

class ShownSymbolField implements StateValueField<ShownSymbol> {
  final ShownSymbol shownSymbol;

  ShownSymbolField(this.shownSymbol);

  @override
  StateValueField<ShownSymbol> transform(TestResults t) {
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

  @override
  ShownSymbol operator ~() {
    return shownSymbol;
  }
}

class ReactionWindowStatusField
    implements StateValueField<ReactionWindowStatus> {
  final ReactionWindowStatus status;

  ReactionWindowStatusField(this.status);

  @override
  StateValueField<ReactionWindowStatus> transform(TestResults t) {
    bool newSymbol = ~t.get(PredicateID.DID_NEW_SYMBOL);
    bool closingOrClosed =
        t.or([PredicateID.IS_WINDOW_CLOSED, PredicateID.IS_WINDOW_CLOSING]);
    return ReactionWindowStatusField(
        ReactionWindowStatus(!closingOrClosed || newSymbol));
  }

  @override
  ReactionWindowStatus operator ~() {
    return status;
  }
}

class ReactionWindowField implements StateValueField<WindowLength> {
  final WindowLength windowLength;

  final Minimum minimum; //0
  final Maximum maximum; //1

  final NormalSymbolTotalField normalTotal;
  final KillerSymbolTotalField killerTotal;

  final Scalar scalar; //2
  final Multiplier multiplier; //3
  final Adjust adj;

  ReactionWindowField(
      this.windowLength,
      this.minimum,
      this.maximum,
      this.normalTotal,
      this.killerTotal,
      this.scalar,
      this.multiplier,
      this.adj);

  @override
  StateValueField<WindowLength> transform(TestResults t) {
    NormalSymbolTotalField newNormTotal = normalTotal.transform(t);
    KillerSymbolTotalField newKillerTotal = killerTotal.transform(t);

    int total = ~~newNormTotal + ~~newKillerTotal;

    Adjust newAdj = Adjust(~getAdj(t) * total);

    int newWindowLength = (~scalar * ~maximum) + ~newAdj;
    newWindowLength = max(~minimum, newWindowLength);
    newWindowLength = min(~maximum, newWindowLength);

    WindowLength postHardeningLength = WindowLength(newWindowLength);

    ReactionWindowField newIntervalField = ReactionWindowField(
        postHardeningLength,
        minimum,
        maximum,
        newNormTotal,
        newKillerTotal,
        scalar,
        multiplier,
        newAdj);

    return newIntervalField;
  } //5

  Minimum getMin(TestResults t) {
    if (~t.get(PredicateID.IS_EASY)) {
      return Minimum(Constants.minReactionWindowEasy);
    } else if (~t.get(PredicateID.IS_MEDIUM)) {
      return Minimum(Constants.minReactionWindowMedium);
    } else if (~t.get(PredicateID.IS_HARD)) {
      return Minimum(Constants.minReactionWindowHard);
    } else if (~t.get(PredicateID.IS_HERO)) {
      return Minimum(Constants.minReactionWindowHero);
    } else {
      throw Exception("How did you manage to do that?");
    }
  }

  Maximum getMax(TestResults t) {
    if (~t.get(PredicateID.IS_EASY)) {
      return Maximum(Constants.maxReactionWindowEasy);
    } else if (~t.get(PredicateID.IS_MEDIUM)) {
      return Maximum(Constants.maxReactionWindowMedium);
    } else if (~t.get(PredicateID.IS_HARD)) {
      return Maximum(Constants.maxReactionWindowHard);
    } else if (~t.get(PredicateID.IS_HERO)) {
      return Maximum(Constants.maxReactionWindowHero);
    } else {
      throw Exception("How did you manage to do that?");
    }
  }

  Adjust getAdj(TestResults t) {
    if (~t.get(PredicateID.IS_EASY)) {
      return Adjust(Constants.reactionWindowAdjEasy);
    } else if (~t.get(PredicateID.IS_MEDIUM)) {
      return Adjust(Constants.reactionWindowAdjMedium);
    } else if (~t.get(PredicateID.IS_HARD)) {
      return Adjust(Constants.reactionWindowAdjHard);
    } else if (~t.get(PredicateID.IS_HERO)) {
      return Adjust(Constants.reactionWindowAdjHero);
    } else {
      throw Exception("How did you manage to do that?");
    }
  }

  @override
  WindowLength operator ~() {
    return windowLength;
  }
}
