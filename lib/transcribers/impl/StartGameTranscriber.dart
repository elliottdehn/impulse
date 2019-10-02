import 'package:impulse/state/AppStateStore.dart';

import '../Transcriber.dart';

class StartGameTranscriber extends Transcriber {
  @override
  writeToState() {
    //TODO make these initial values config values
    manager.updateState(AppStateKey.SYMBOL, "");
    manager.updateState(AppStateKey.LIVES, 3);
    manager.updateState(AppStateKey.SYMBOL_TAPPED_COUNT, 0);
    manager.updateState(AppStateKey.NORMAL_SYMBOL_STREAK, 0);
    manager.updateState(AppStateKey.KILLER_SYMBOL_STREAK, 0);
    manager.updateState(AppStateKey.NORMAL_SYMBOL_TOTAL, 0);
    manager.updateState(AppStateKey.KILLER_SYMBOL_TOTAL, 0);
    manager.updateState(AppStateKey.REACTION_WINDOW_CLOSED, true);
  }
}
