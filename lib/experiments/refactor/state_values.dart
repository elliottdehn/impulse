import 'package:impulse/experiments/values.dart';

import 'field_id.dart';
import 'test_results.dart';

class StateValues {
  final Tuple<FieldID, TapCount> tapCount;
  final Tuple<FieldID, NormalSymbolTotal> normalSymbolTotal;
  final Tuple<FieldID, KillerSymbolTotal> killerSymbolTotal;
  final Tuple<FieldID, ShownSymbol> shownSymbol;
  final Tuple<FieldID, Score> score;
  final Tuple<FieldID, IntervalLength> intervalLength;
  final Tuple<FieldID, ReactionWindowLength> reactionWindowLength;
  final Tuple<FieldID, ReactionWindowStatus> reactionWindowStatus;
  final Tuple<FieldID, Lives> lives;

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
