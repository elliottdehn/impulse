import 'package:impulse/experiments/values.dart';

class StateValues {

  final TapCount tapCount;
  final NormalSymbolTotal normalSymbolTotal;
  final KillerSymbolTotal killerSymbolTotal;
  final ShownSymbol shownSymbol;
  final Score score;
  final IntervalLength intervalLength;
  final ReactionWindowLength reactionWindowLength;
  final ReactionWindowStatus reactionWindowStatus;
  final Lives lives;

  StateValues(
      this.tapCount,
      this.normalSymbolTotal,
      this.killerSymbolTotal,
      this.shownSymbol,
      this.score,
      this.intervalLength,
      this.reactionWindowLength,
      this.reactionWindowStatus,
      this.lives);
}
