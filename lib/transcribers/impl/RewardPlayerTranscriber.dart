import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/transcribers/Transcriber.dart';

class RewardPlayerTranscriber extends Transcriber {
  @override
  writeToState() {
    //this can also "do nothing", since the dichotomy is reward vs hurt
    String symbol = manager.getStateValue(AppStateKey.SYMBOL);
    List<String> killerSymbols =
        manager.getConfigValue(AppConfigKey.FAILURE_LETTERS);
    bool isKillerSymbol = killerSymbols.contains(symbol);
    bool isMissedWindow = manager.getStateValue(AppStateKey.REACTION_WINDOW_CLOSED);
    int taps = manager.getStateValue(AppStateKey.SYMBOL_TAPPED_COUNT);
    if (isKillerSymbol) {
      int killerSymbolTotal = manager.getStateValue(AppStateKey.KILLER_SYMBOL_TOTAL);
      manager.updateState(AppStateKey.KILLER_SYMBOL_TOTAL, killerSymbolTotal + 1);
      int killerSymbolStreak =
          manager.getStateValue(AppStateKey.KILLER_SYMBOL_STREAK);
      manager.updateState(
          AppStateKey.KILLER_SYMBOL_STREAK, killerSymbolStreak + 1);
    } else if(!isMissedWindow && taps == 1){
      int successSymbolTotal = manager.getStateValue(AppStateKey.NORMAL_SYMBOL_TOTAL);
      manager.updateState(AppStateKey.NORMAL_SYMBOL_TOTAL, successSymbolTotal + 1);
      int normalSymbolStreak =
          manager.getStateValue(AppStateKey.NORMAL_SYMBOL_STREAK);
      manager.updateState(
          AppStateKey.NORMAL_SYMBOL_STREAK, normalSymbolStreak + 1);
    }
  }
}
