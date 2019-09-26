import 'package:impulse/state/AppStateStore.dart';

import '../Transcriber.dart';

class PlayerTrappedTranscriber extends Transcriber {
  @override
  writeToState() {
    int tapCount = manager.getStateValue(AppStateKey.SYMBOL_TAPPED_COUNT);
    manager.updateState(AppStateKey.SYMBOL_TAPPED_COUNT, tapCount + 1);
  }
}
