import 'package:impulse/state/AppStateStore.dart';

import '../Transcriber.dart';

class PlayerTappedTranscriber extends Transcriber {
  @override
  writeToState() {
    int newTapCount = (manager.getStateValue(AppStateKey.SYMBOL_TAPPED_COUNT) as int) + 1;
    manager.updateState(AppStateKey.SYMBOL_TAPPED_COUNT, newTapCount);
  }
}
