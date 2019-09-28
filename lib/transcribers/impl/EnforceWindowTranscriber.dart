import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/transcribers/ITranscriber.dart';
import 'package:impulse/transcribers/impl/HurtPlayerTranscriber.dart';

import '../Transcriber.dart';

class EnforceWindowTranscriber extends Transcriber {

  final ITranscriber hurtPlayer = HurtPlayerTranscriber();

  List<String> _normalSymbols;

  EnforceWindowTranscriber(){
    _normalSymbols = manager.getConfigValue(AppConfigKey.SUCCESS_LETTERS);
  }

  @override
  writeToState() {
    if(_isNormalSymbolAndNotTapped()){
      hurtPlayer.writeToState();
    } else if (_isKillerSymbolAndNotTapped()){
      int killerSymbolTotal = manager.getStateValue(AppStateKey.KILLER_SYMBOL_TOTAL);
      manager.updateState(AppStateKey.KILLER_SYMBOL_TOTAL, killerSymbolTotal + 1);
    }
  }

  _isNormalSymbolAndNotTapped() {
    bool tapped = (manager.getStateValue(
        AppStateKey.SYMBOL_TAPPED_COUNT) as int) > 0;
    String symbol = manager.getStateValue(AppStateKey.SYMBOL);
    bool normalSymbol = _normalSymbols.contains(symbol);
    return !tapped && normalSymbol;
  }

  _isKillerSymbolAndNotTapped(){
    bool tapped = (manager.getStateValue(
        AppStateKey.SYMBOL_TAPPED_COUNT) as int) > 0;
    String symbol = manager.getStateValue(AppStateKey.SYMBOL);
    bool normalSymbol = !_normalSymbols.contains(symbol);
    return !tapped && !normalSymbol;
  }
}