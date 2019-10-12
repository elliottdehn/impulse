import 'package:impulse/experiments/refactor/id/difficulty_id.dart';

import '../../constants.dart';
import 'transformer.dart';
import 'transformers.dart';

class TransformerBuilder {
  final List<StateValueField> initialFields = [];

  TransformerBuilder() {
    //these do not vary between difficulties
    TapCountField tcf = TapCountField(0);
    NormalSymbolTotalField nstf = NormalSymbolTotalField(0);
    KillerSymbolTotalField kstf = KillerSymbolTotalField(0);
    ShownSymbolField ssf = ShownSymbolField("");
    ReactionWindowStatusField rwsf = ReactionWindowStatusField(false);

    initialFields.addAll([tcf, nstf, kstf, ssf, rwsf]);
  }

  TransformerBuilder setDifficulty(DifficultyID difficultyID) {
    //we can reuse these because I designed them to be immutable
    IntervalLengthField ilf = IntervalLengthField(Constants.intervalSlow);
    NormalSymbolTotalField nstf = NormalSymbolTotalField(0);
    KillerSymbolTotalField kstf = KillerSymbolTotalField(0);

    DifficultyField df = DifficultyField(difficultyID);
    ReactionWindowLengthField rwlf;
    LivesTotalField ltf;

    if (DifficultyID.EASY == ~df) {
      rwlf = ReactionWindowLengthField(Constants.maxReactionWindowEasy,
          nstf, kstf, ilf);
      ltf = LivesTotalField(Constants.livesStartEasy);
    } else if (DifficultyID.MEDIUM == ~df) {
      rwlf = ReactionWindowLengthField(Constants.maxReactionWindowMedium,
          nstf, kstf, ilf);
      ltf = LivesTotalField(Constants.livesStartMedium);
    } else if (DifficultyID.HARD == ~df) {
      rwlf = ReactionWindowLengthField(Constants.maxReactionWindowHard,
          nstf, kstf, ilf);
      ltf = LivesTotalField(Constants.livesStartHard);
    } else if (DifficultyID.HERO == ~df) {
      rwlf = ReactionWindowLengthField(Constants.maxReactionWindowHero,
          nstf, kstf, ilf);
      ltf = LivesTotalField(Constants.livesStartHero);
    }

    initialFields.add(df);
    initialFields.add(rwlf);
    initialFields.add(ltf);

    return this;
  }

  build() {
    return StateTransformer(StateFields(initialFields));
  }
}
