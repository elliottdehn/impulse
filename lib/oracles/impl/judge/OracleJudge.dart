import 'package:impulse/state/AppStateStore.dart';

import '../../Oracle.dart';

class OracleJudge extends Oracle {
  List<String> _failSymbols;

  OracleJudge() {
    _failSymbols = manager.getConfigValue(AppConfigKey.FAILURE_LETTERS);
  }

  @override
  getAnswer() {
    //true = reward the player
    //false = hurt the player
    return !_isTappedOnKillerSymbol() &&
        !_isNormalSymbolAndNotTapped();
  }

  _isTappedOnKillerSymbol() {
    var currentSymbol = manager.getStateValue(AppStateKey.SYMBOL);
    return _failSymbols.contains(currentSymbol) &&
        (manager.getStateValue(AppStateKey.SYMBOL_TAPPED_COUNT) as int > 0);
  }

  _isNormalSymbolAndNotTapped() {
    List<String> _normalSymbols = manager.getConfigValue(AppConfigKey.SUCCESS_LETTERS);
    bool tapped = (manager.getStateValue(
        AppStateKey.SYMBOL_TAPPED_COUNT) as int) > 0;
    String symbol = manager.getStateValue(AppStateKey.SYMBOL);
    bool normalSymbol = _normalSymbols.contains(symbol);
    return !tapped && normalSymbol;
  }

}
