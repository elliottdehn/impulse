import 'package:impulse/state/AppStateStore.dart';

import '../Transcriber.dart';

class TranscriberPlayerTapped extends Transcriber {
  @override
  writeToState() {
    int tapCount = manager.getStateValue(AppStateKey.SYMBOL_TAPPED_COUNT);
    manager.updateState(AppStateKey.SYMBOL_TAPPED_COUNT, tapCount + 1);
  }
}
