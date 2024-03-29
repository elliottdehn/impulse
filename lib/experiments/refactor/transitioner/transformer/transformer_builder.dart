import 'dart:math';

import 'package:impulse/experiments/refactor/id/difficulty_id.dart';

import '../../constants.dart';
import 'transformer.dart';
import 'transformers.dart';

class TransformerBuilder {
  final List<StateValueField> initialFields = [];
  static final Random initRandomForWindow = Random(Constants.randomRandomSeed);
  static final Random initRandomForInterval =
      Random(Constants.randomRandomSeed);
  static final Random initRandomForSymbol = Random(Constants.randomRandomSeed);

  TransformerBuilder() {
    //these do not vary between difficulties
    TapCountField tcf = TapCountField(0);
    NormalSymbolTotalField nstf = NormalSymbolTotalField(0);
    KillerSymbolTotalField kstf = KillerSymbolTotalField(0);
    ShownSymbolField ssf = ShownSymbolField("", initRandomForSymbol);
    ReactionWindowStatusField rwsf = ReactionWindowStatusField(false);

    NormalSymbolTotalField nstf2 = NormalSymbolTotalField(0);
    ReactionTimesField rtf = ReactionTimesField([], nstf2, Stopwatch());

    initialFields.addAll([tcf, nstf, kstf, ssf, rwsf, rtf]);
  }

  TransformerBuilder setDifficulty(DifficultyID difficultyID) {
    //we can reuse these because I designed them to be immutable

    NormalSymbolTotalField nstf = NormalSymbolTotalField(0);
    KillerSymbolTotalField kstf = KillerSymbolTotalField(0);
    TapCountField tcf = TapCountField(0);
    ScoreField sf = ScoreField(0, tcf, nstf, kstf);

    DifficultyField df = DifficultyField(difficultyID);

    ReactionWindowLengthField rwlf;
    LivesTotalField ltf;

    IntervalLengthField ilfForReactionWindow =
        IntervalLengthField(Constants.intervalSlow, initRandomForWindow);
    IntervalLengthField ilf =
        IntervalLengthField(Constants.intervalSlow, initRandomForInterval);

    if (DifficultyID.EASY == ~df) {
      rwlf = ReactionWindowLengthField(
          Constants.maxReactionWindowEasy, nstf, kstf, ilfForReactionWindow);
      ltf = LivesTotalField(Constants.livesStartEasy);
    } else if (DifficultyID.MEDIUM == ~df) {
      rwlf = ReactionWindowLengthField(
          Constants.maxReactionWindowMedium, nstf, kstf, ilfForReactionWindow);
      ltf = LivesTotalField(Constants.livesStartMedium);
    } else if (DifficultyID.HARD == ~df) {
      rwlf = ReactionWindowLengthField(
          Constants.maxReactionWindowHard, nstf, kstf, ilfForReactionWindow);
      ltf = LivesTotalField(Constants.livesStartHard);
    } else if (DifficultyID.HERO == ~df) {
      rwlf = ReactionWindowLengthField(
          Constants.maxReactionWindowHero, nstf, kstf, ilfForReactionWindow);
      ltf = LivesTotalField(Constants.livesStartHero);
    }

    initialFields.add(df);
    initialFields.add(rwlf);
    initialFields.add(ltf);
    initialFields.add(ilf);
    initialFields.add(sf);

    return this;
  }

  build() {
    return StateTransformer(StateFields(initialFields));
  }
}
