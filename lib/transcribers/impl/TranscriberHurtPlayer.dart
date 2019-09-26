import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/transcribers/Transcriber.dart';

class TranscriberHurtPlayer extends Transcriber {
  @override
  writeToState() {
    bool symbol = manager.getStateValue(AppStateKey.SYMBOL);
    List<String> killerSymbols =
        manager.getConfigValue(AppConfigKey.FAILURE_LETTERS);
    bool isKillerSymbol = killerSymbols.contains(symbol);
    int currentLives = manager.getStateValue(AppStateKey.LIVES);
    manager.updateState(AppStateKey.LIVES, currentLives - 1);
    if (isKillerSymbol) {
      manager.updateState(AppStateKey.KILLER_SYMBOL_STREAK, 0);
    } else {
      manager.updateState(AppStateKey.NORMAL_SYMBOL_STREAK, 0);
    }
  }
}
