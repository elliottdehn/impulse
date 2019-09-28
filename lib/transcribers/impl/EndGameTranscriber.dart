import 'package:impulse/state/AppStateStore.dart';

import '../Transcriber.dart';

class EndGameTranscriber extends Transcriber {
  @override
  writeToState() {
    manager.updateState(AppStateKey.SYMBOL, null);
    manager.updateState(AppStateKey.LIVES, null);
    manager.updateState(AppStateKey.SYMBOL_TAPPED_COUNT, null);
    manager.updateState(AppStateKey.NORMAL_SYMBOL_STREAK, null);
    manager.updateState(AppStateKey.KILLER_SYMBOL_STREAK, null);
    manager.updateState(AppStateKey.NORMAL_SYMBOL_TOTAL, null);
    manager.updateState(AppStateKey.KILLER_SYMBOL_TOTAL, null);
    manager.updateState(AppStateKey.PLAYER_MISSED_WINDOW, null);
  }

}