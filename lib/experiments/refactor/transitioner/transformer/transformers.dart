import 'dart:math';

import 'package:impulse/experiments/refactor/id/difficulty_id.dart';
import 'package:impulse/widgets/EventID.dart';

import '../../constants.dart';
import '../../id/field_id.dart';
import '../../id/result_id.dart';
import '../predicator/test_results.dart';
import '../../../values.dart';
import 'transformer.dart';

/*
definitions
 */

class StateFields {
  final List<StateValueField> fields;

  StateFields(this.fields);

  StateValueField get(FieldID id) {
    fields.retainWhere((element) => element.getId() == id);
    return fields[0];
  }
}

abstract class StateValueField<X extends Value>
    with Transform<StateValueField> {
  StateValueField<Value> transform(TestResults t);

  dynamic operator ~();

  FieldID getId();
}

/*
impl
 */

class DifficultyField implements StateValueField<Difficulty> {
  final DifficultyID difficulty;

  DifficultyField(this.difficulty);

  @override
  FieldID getId() {
    return FieldID.DIFFICULTY;
  }

  @override
  StateValueField<Value> transform(TestResults t) {
    return DifficultyField(difficulty);
  }

  @override
  operator ~() {
    return difficulty;
  }
}

class TapCountField implements StateValueField<TapCount> {
  final int _iTapCount;

  TapCountField(this._iTapCount);

  @override
  StateValueField<TapCount> transform(TestResults t) {
    bool didReact = ~t.get(ResultID.DID_PLAYER_REACT);
    bool isNewSymbol = ~t.get(ResultID.DID_NEW_SYMBOL);
    if (didReact) {
      return new TapCountField(_iTapCount + 1);
    } else if (isNewSymbol) {
      return new TapCountField(0);
    } else {
      return this;
    }
  }

  @override
  int operator ~() {
    return _iTapCount;
  }

  @override
  FieldID getId() {
    return FieldID.TAP_COUNT;
  }
}

class NormalSymbolTotalField implements StateValueField<NormalSymbolTotal> {
  final int _iTotal;

  NormalSymbolTotalField(this._iTotal);

  @override
  StateValueField<NormalSymbolTotal> transform(TestResults t) {
    bool rewardPlayer = t.and([
      ResultID.DID_FIRST_TAP,
      ResultID.IS_NORMAL_SYMBOL,
      ResultID.IS_WINDOW_OPEN
    ]);
    if (rewardPlayer) {
      return NormalSymbolTotalField(_iTotal + 1);
    } else {
      return this;
    }
  }

  @override
  int operator ~() {
    return _iTotal;
  }

  @override
  FieldID getId() {
    return FieldID.NORMAL_SYMBOL_TOTAL;
  }
}

class KillerSymbolTotalField implements StateValueField<KillerSymbolTotal> {
  final int _iKillerTotal;

  KillerSymbolTotalField(this._iKillerTotal);

  @override
  StateValueField<KillerSymbolTotal> transform(TestResults t) {
    bool rewardPlayer = t.and([
      ResultID.IS_TAPPED_ZERO,
      ResultID.DID_NEW_SYMBOL,
      ResultID.IS_KILLER_SYMBOL
    ]);
    if (rewardPlayer) {
      return KillerSymbolTotalField(_iKillerTotal + 1);
    } else {
      return this;
    }
  }

  @override
  int operator ~() {
    return _iKillerTotal;
  }

  @override
  FieldID getId() {
    return FieldID.KILLER_SYMBOL_TOTAL;
  }
}

class LivesTotalField implements StateValueField<LivesTotal> {
  final int _iLives;
  LivesTotal _lives;

  LivesTotalField(this._iLives) {
    _lives = LivesTotal(_iLives);
  }

  @override
  StateValueField<LivesTotal> transform(TestResults t) {
    bool playedReactedOnKiller =
        t.and([ResultID.DID_PLAYER_REACT, ResultID.IS_KILLER_SYMBOL]);
    bool noReactsOnNormal = t.and([
      ResultID.IS_NORMAL_SYMBOL,
      ResultID.IS_WINDOW_CLOSING,
      ResultID.IS_TAPPED_ZERO
    ]);
    if (playedReactedOnKiller || noReactsOnNormal) {
      return LivesTotalField(~_lives - 1);
    } else {
      return this;
    }
  }

  Lives getStartLives(TestResults t) {
    if (~t.get(ResultID.IS_EASY)) {
      return Lives(Constants.livesStartEasy);
    } else if (~t.get(ResultID.IS_MEDIUM)) {
      return Lives(Constants.livesStartMedium);
    } else if (~t.get(ResultID.IS_HARD)) {
      return Lives(Constants.livesStartHard);
    } else if (~t.get(ResultID.IS_HERO)) {
      return Lives(Constants.livesStartHero);
    } else {
      throw Exception("How did you manage to do that?");
    }
  }

  @override
  int operator ~() {
    return ~_lives;
  }

  @override
  FieldID getId() {
    return FieldID.LIVES;
  }
}

class ShownSymbolField implements StateValueField<ShownSymbol> {
  final String _sShownSymbol;
  static final Random _random = Random(Constants.randomRandomSeed);

  ShownSymbolField(this._sShownSymbol);

  @override
  StateValueField<ShownSymbol> transform(TestResults t) {
    DidNewSymbol isNewSymbol = t.get(ResultID.DID_NEW_SYMBOL);
    if (~isNewSymbol) {
      bool isNormalSymbol = _random.nextDouble() <= Constants.normalOdds;
      String oldSymbol = _sShownSymbol;
      String newSymbol;
      if (isNormalSymbol) {
        while (oldSymbol == newSymbol) {
          newSymbol = Constants
              .normalSymbols[_random.nextInt(Constants.normalSymbols.length)];
        }
      } else {
        newSymbol = Constants
            .killerSymbols[_random.nextInt(Constants.killerSymbols.length)];
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

  @override
  FieldID getId() {
    return FieldID.SHOWN_SYMBOL;
  }
}

class ReactionWindowStatusField
    implements StateValueField<ReactionWindowStatus> {
  final bool _bStatus;

  ReactionWindowStatusField(this._bStatus);

  @override
  StateValueField<ReactionWindowStatus> transform(TestResults t) {
    bool newSymbol = ~t.get(ResultID.DID_NEW_SYMBOL);
    bool closingOrClosed =
        t.or([ResultID.IS_WINDOW_CLOSED, ResultID.IS_WINDOW_CLOSING]);
    return ReactionWindowStatusField(!closingOrClosed || newSymbol);
  }

  @override
  bool operator ~() {
    return _bStatus;
  }

  @override
  FieldID getId() {
    return FieldID.REACTION_WINDOW_STATUS;
  }
}

class ReactionWindowLengthField
    implements StateValueField<ReactionWindowLength> {
  final int _iWindowLength;

  final NormalSymbolTotalField normalTotal;
  final KillerSymbolTotalField killerTotal;
  final IntervalLengthField intervalLengthField;

  final Scalar scalar = Scalar(1.0);

  ReactionWindowLengthField(this._iWindowLength, this.normalTotal,
      this.killerTotal, this.intervalLengthField);

  @override
  StateValueField<ReactionWindowLength> transform(TestResults t) {
    NormalSymbolTotalField newNormTotal = normalTotal.transform(t);
    KillerSymbolTotalField newKillerTotal = killerTotal.transform(t);
    IntervalLengthField newInterval = intervalLengthField.transform(t);

    if (~t.get(ResultID.DID_NEW_SYMBOL)) {
      int total = ~~newNormTotal + ~~newKillerTotal;

      Adjust newAdj = Adjust(~getAdj(t) * total);

      Minimum minimum = getMin(t);
      Maximum maximum = getMax(t);

      int newWindowLength = (~scalar * ~maximum) + ~newAdj;
      //make sure that the window is not inhumanly fast
      int newWindowLengthBottomed = max(~minimum, newWindowLength);
      //do not want window to be longer than the interval
      int actualMax = min(~intervalLengthField, ~maximum);
      int newWindowLengthTopped = min(~actualMax, newWindowLengthBottomed);

      ReactionWindowLengthField newIntervalField = ReactionWindowLengthField(
          newWindowLengthTopped, newNormTotal, newKillerTotal, newInterval);

      return newIntervalField;
    } else {
      return this;
    }
  }

  Minimum getMin(TestResults t) {
    if (~t.get(ResultID.IS_EASY)) {
      return Minimum(Constants.minReactionWindowEasy);
    } else if (~t.get(ResultID.IS_MEDIUM)) {
      return Minimum(Constants.minReactionWindowMedium);
    } else if (~t.get(ResultID.IS_HARD)) {
      return Minimum(Constants.minReactionWindowHard);
    } else if (~t.get(ResultID.IS_HERO)) {
      return Minimum(Constants.minReactionWindowHero);
    } else {
      throw Exception("How did you manage to do that?");
    }
  }

  Maximum getMax(TestResults t) {
    if (~t.get(ResultID.IS_EASY)) {
      return Maximum(Constants.maxReactionWindowEasy);
    } else if (~t.get(ResultID.IS_MEDIUM)) {
      return Maximum(Constants.maxReactionWindowMedium);
    } else if (~t.get(ResultID.IS_HARD)) {
      return Maximum(Constants.maxReactionWindowHard);
    } else if (~t.get(ResultID.IS_HERO)) {
      return Maximum(Constants.maxReactionWindowHero);
    } else {
      throw Exception("How did you manage to do that?");
    }
  }

  Adjust getAdj(TestResults t) {
    if (~t.get(ResultID.IS_EASY)) {
      return Adjust(Constants.reactionWindowAdjEasy);
    } else if (~t.get(ResultID.IS_MEDIUM)) {
      return Adjust(Constants.reactionWindowAdjMedium);
    } else if (~t.get(ResultID.IS_HARD)) {
      return Adjust(Constants.reactionWindowAdjHard);
    } else if (~t.get(ResultID.IS_HERO)) {
      return Adjust(Constants.reactionWindowAdjHero);
    } else {
      throw Exception("How did you manage to do that?");
    }
  }

  @override
  int operator ~() {
    return _iWindowLength;
  }

  @override
  FieldID getId() {
    return FieldID.REACTION_WINDOW_LENGTH;
  }
}

class IntervalLengthField extends StateValueField<IntervalLength> {
  final int _iIntervalLength;
  static final Random _random = Random(Constants.randomRandomSeed);

  IntervalLengthField(this._iIntervalLength);

  @override
  StateValueField<Value> transform(TestResults t) {
    if (~t.get(ResultID.DID_NEW_SYMBOL)) {
      int randomLength = _random
              .nextInt(Constants.intervals.last - Constants.intervals.first) +
          Constants.intervals.first;
      return IntervalLengthField(randomLength);
    } else {
      return this;
    }
  }

  @override
  operator ~() {
    return _iIntervalLength;
  }

  @override
  FieldID getId() {
    return FieldID.INTERVAL_LENGTH;
  }
}

class ScoreField extends StateValueField<Score> {
  final int _iScore;
  final TapCountField _tc;
  final NormalSymbolTotalField _normalTotal;
  final KillerSymbolTotalField _killerTotal;

  ScoreField(this._iScore, this._tc, this._normalTotal, this._killerTotal);

  @override
  StateValueField<Value> transform(TestResults t) {
    var newTc = _tc.transform(t);
    var newNormalTotal = _normalTotal.transform(t);
    var newKillerTotal = _killerTotal.transform(t);

    int excessTaps = 0;
    if (~t.get(ResultID.IS_NORMAL_SYMBOL) && ~newTc > 1) {
      excessTaps = ~newTc - 1;
    }
    int newScore =
        (50 * ~newNormalTotal) + (500 * ~newKillerTotal) - (25 * excessTaps);
    double adjScore = getMultiplier(t) * newScore;
    int roundScore = adjScore.round();
    int bottomedScore = max(0, roundScore);
    return ScoreField(bottomedScore, newTc, newNormalTotal, newKillerTotal);
  }

  double getMultiplier(TestResults t) {
    if (~t.get(ResultID.IS_EASY)) {
      return Constants.easyScoreMultiplier;
    } else if (~t.get(ResultID.IS_MEDIUM)) {
      return Constants.mediumScoreMultiplier;
    } else if (~t.get(ResultID.IS_HARD)) {
      return Constants.hardScoreMultiplier;
    } else if (~t.get(ResultID.IS_HERO)) {
      return Constants.heroScoreMultiplier;
    } else {
      throw Exception("How did you manage to do that?");
    }
  }

  @override
  operator ~() {
    return _iScore;
  }

  @override
  FieldID getId() {
    return FieldID.SCORE;
  }
}
