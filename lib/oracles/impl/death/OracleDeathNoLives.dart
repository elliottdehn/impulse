import 'package:impulse/state/AppStateStore.dart';

import '../../Oracle.dart';

class OracleDeathNoLives extends Oracle {

  List<String> _failSymbols;

  OracleDeathNoLives(){
    _failSymbols = manager.getConfigValue(AppConfigKey.FAILURE_LETTERS);
  }

  @override
  getAnswer() {
    var currentSymbol = manager.getStateValue(AppStateKey.SYMBOL);
    return !_failSymbols.contains(currentSymbol);
  }

}