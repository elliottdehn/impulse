import 'package:impulse/state/AppStateStore.dart';

import '../Transcriber.dart';

class PlayerTappedTranscriber extends Transcriber {
  @override
  writeToState() {
    int newTapCount = (manager.getStateValue(AppStateKey.SYMBOL_TAPPED_COUNT) as int) + 1;
    manager.updateState(AppStateKey.SYMBOL_TAPPED_COUNT, newTapCount);
    if(newTapCount == 1){
      String symbol = manager.getStateValue(AppStateKey.SYMBOL);
      List<String> successSymbols = manager.getConfigValue(AppConfigKey.SUCCESS_LETTERS);
      if(successSymbols.contains(symbol)){
        int successSymbolTotal = manager.getStateValue(AppStateKey.NORMAL_SYMBOL_TOTAL);
        manager.updateState(AppStateKey.NORMAL_SYMBOL_TOTAL, successSymbolTotal + 1);
      }
    }
  }
}
