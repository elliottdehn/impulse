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

/*
Definitions---------------------
 */

mixin Transform<T extends Transform<T>> {
  T transform(TestResults t);
}

abstract class StateValueField<X extends Value>
    with Transform<StateValueField> {
  StateValueField<Value> transform(TestResults t);

  dynamic operator ~();
}
/*
End definitions-----------------
 */

class TapCountField implements StateValueField<TapCount> {
  final int _iTapCount;
  TapCount _tapCount;

  TapCountField(this._iTapCount);

  @override
  StateValueField<TapCount> transform(TestResults t) {
    DidPlayerReact didReact = t.get(PredicateID.DID_PLAYER_REACT);
    IsNewSymbol isNewSymbol = t.get(PredicateID.DID_NEW_SYMBOL);
    if (~didReact) {
      return new TapCountField(~_tapCount + 1);
    } else if (~isNewSymbol) {
      return new TapCountField(0);
    } else {
      return this;
    }
  }

  @override
  int operator ~() {
    return _iTapCount;
  }
}

class NormalSymbolTotalField implements StateValueField<NormalSymbolTotal> {
  final int _iTotal;
  NormalSymbolTotal _total;

  NormalSymbolTotalField(this._iTotal);

  @override
  StateValueField<NormalSymbolTotal> transform(TestResults t) {
    bool rewardPlayer = t.and([
      PredicateID.DID_FIRST_TAP,
      PredicateID.IS_NORMAL_SYMBOL,
      PredicateID.IS_WINDOW_OPEN
    ]);
    if (rewardPlayer) {
      return NormalSymbolTotalField(~_total + 1);
    } else {
      return this;
    }
  }

  @override
  int operator ~() {
    return _iTotal;
  }
}

class KillerSymbolTotalField implements StateValueField<KillerSymbolTotal> {
  final int _iKillerTotal;
  KillerSymbolTotal _total;

  KillerSymbolTotalField(this._iKillerTotal);

  @override
  StateValueField<KillerSymbolTotal> transform(TestResults t) {
    bool rewardPlayer = t.and([
      PredicateID.DID_NEW_SYMBOL,
      PredicateID.IS_TAPPED_ZERO,
      PredicateID.IS_KILLER_SYMBOL
    ]);
    if (rewardPlayer) {
      return KillerSymbolTotalField(~_total + 1);
    } else {
      return this;
    }
  }

  @override
  int operator ~() {
    return _iKillerTotal;
  }
}

class LivesTotalField implements StateValueField<LivesTotal> {
  final int _iLives;
  LivesTotal _lives;

  LivesTotalField(this._iLives){
    _lives = LivesTotal(_iLives);
  }

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
      return LivesTotalField(~_lives - 1);
    } else {
      return this;
    }
  }

  @override
  int operator ~() {
    return ~_lives;
  }
}

class ShownSymbolField implements StateValueField<ShownSymbol> {
  final String _sShownSymbol;

  ShownSymbolField(this._sShownSymbol);

  @override
  StateValueField<ShownSymbol> transform(TestResults t) {
    IsNewSymbol isNewSymbol = t.get(PredicateID.DID_NEW_SYMBOL);
    if (~isNewSymbol) {
      var random = Random.secure();
      bool isNormalSymbol = random.nextDouble() <= Constants.normalOdds;
      String oldSymbol = _sShownSymbol;
      String newSymbol;
      if (isNormalSymbol) {
        while(oldSymbol == newSymbol) {
          newSymbol = Constants
              .normalSymbols[random.nextInt(Constants.normalSymbols.length)];
        }
      } else {
        newSymbol = Constants
            .killerSymbols[random.nextInt(Constants.killerSymbols.length)];
      }
      return ShownSymbolField(newSymbol);
    } else {
      return this;
    }
  }

  @override
  String operator ~() {
    return _sShownSymbol;
  }
}

class ReactionWindowStatusField
    implements StateValueField<ReactionWindowStatus> {
  final bool _bStatus;

  ReactionWindowStatusField(this._bStatus);

  @override
  StateValueField<Value<bool>> transform(TestResults t) {
    bool newSymbol = ~t.get(PredicateID.DID_NEW_SYMBOL);
    bool closingOrClosed =
        t.or([PredicateID.IS_WINDOW_CLOSED, PredicateID.IS_WINDOW_CLOSING]);
    return ReactionWindowStatusField(!closingOrClosed || newSymbol);
  }

  @override
  bool operator ~() {
    return _bStatus;
  }
}

class ReactionWindowLengthField
    implements StateValueField<ReactionWindowLength> {
  final int _iWindowLength;

  final Minimum minimum; //0
  final Maximum maximum; //1

  final NormalSymbolTotalField normalTotal;
  final KillerSymbolTotalField killerTotal;

  final Scalar scalar; //2
  final Multiplier multiplier; //3
  final Adjust adj;

  ReactionWindowLengthField(
      this._iWindowLength,
      this.minimum,
      this.maximum,
      this.normalTotal,
      this.killerTotal,
      this.scalar,
      this.multiplier,
      this.adj);

  @override
  StateValueField<ReactionWindowLength> transform(TestResults t) {
    NormalSymbolTotalField newNormTotal = normalTotal.transform(t);
    KillerSymbolTotalField newKillerTotal = killerTotal.transform(t);

    int total = ~~newNormTotal + ~~newKillerTotal;

    Adjust newAdj = Adjust(~getAdj(t) * total);

    int newWindowLength = (~scalar * ~maximum) + ~newAdj;
    newWindowLength = max(~minimum, newWindowLength);
    newWindowLength = min(~maximum, newWindowLength);

    ReactionWindowLengthField newIntervalField = ReactionWindowLengthField(
        newWindowLength,
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
  int operator ~() {
    return _iWindowLength;
  }
}
