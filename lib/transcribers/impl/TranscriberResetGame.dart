import 'package:impulse/state/AppStateStore.dart';

import '../Transcriber.dart';

class TranscriberResetGame extends Transcriber {
  @override
  writeToState() {
    manager.updateState(AppStateKey.SYMBOL,"");
    manager.updateState(AppStateKey.SYMBOL_SHOWN_TIME, null);
    manager.updateState(AppStateKey.SYMBOL_TAPPED_COUNT,0);
    manager.updateState(AppStateKey.LIVES,3);
    manager.updateState(AppStateKey.REACTION_TIMES,[]);
    manager.updateState(AppStateKey.NORMAL_SYMBOL_STREAK,0);
    manager.updateState(AppStateKey.KILLER_SYMBOL_STREAK,0);
    manager.updateState(AppStateKey.NORMAL_SYMBOL_TOTAL,0);
    manager.updateState(AppStateKey.KILLER_SYMBOL_TOTAL,0);
  }

}