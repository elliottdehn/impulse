import 'package:impulse/state/AppStateStore.dart';

import '../../Oracle.dart';

class OracleJudge extends Oracle {
  List<String> _failSymbols;

  OracleJudge(){
    _failSymbols = manager.getConfigValue(AppConfigKey.FAILURE_LETTERS);
  }

  @override
  getAnswer() {
    //true = hurt the player
    //false = reward the player
    var currentSymbol = manager.getStateValue(AppStateKey.SYMBOL);
    return (_failSymbols.contains(currentSymbol) && (manager.getStateValue(AppStateKey.SYMBOL_TAPPED_COUNT) as int > 0))
        || (!_failSymbols.contains(currentSymbol) && !(manager.getStateValue(AppStateKey.SYMBOL_TAPPED_COUNT) as int == 1));
  }

}