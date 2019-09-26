import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/transcribers/Transcriber.dart';

class RewardPlayerTranscriber extends Transcriber {
  @override
  writeToState() {
    bool symbol = manager.getStateValue(AppStateKey.SYMBOL);
    List<String> killerSymbols =
        manager.getConfigValue(AppConfigKey.FAILURE_LETTERS);
    bool isKillerSymbol = killerSymbols.contains(symbol);
    if (isKillerSymbol) {
      int killerSymbolStreak =
          manager.getStateValue(AppStateKey.KILLER_SYMBOL_STREAK);
      manager.updateState(
          AppStateKey.KILLER_SYMBOL_STREAK, killerSymbolStreak + 1);
      int killerSymbolTotal =
          manager.getStateValue(AppStateKey.KILLER_SYMBOL_TOTAL);
      manager.updateState(AppStateKey.KILLER_SYMBOL_TOTAL, killerSymbolTotal);
    } else {
      int normalSymbolStreak =
          manager.getStateValue(AppStateKey.NORMAL_SYMBOL_STREAK);
      manager.updateState(
          AppStateKey.KILLER_SYMBOL_STREAK, normalSymbolStreak + 1);
      int normalSymbolTotal =
          manager.getStateValue(AppStateKey.NORMAL_SYMBOL_TOTAL);
      manager.updateState(AppStateKey.KILLER_SYMBOL_TOTAL, normalSymbolTotal);
    }
  }
}
