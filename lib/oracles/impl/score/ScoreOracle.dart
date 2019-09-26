import 'package:impulse/oracles/Oracle.dart';
import 'package:impulse/state/AppStateStore.dart';

class ScoreOracle extends Oracle {
  @override
  getAnswer() {
    return ((manager.getStateValue(AppStateKey.NORMAL_SYMBOL_TOTAL) as int) * 50)
         + ((manager.getStateValue(AppStateKey.KILLER_SYMBOL_TOTAL) as int) * 500);

  }

}