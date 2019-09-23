import 'package:impulse/state/AppStateStore.dart';

import '../Transcriber.dart';

class TranscriberPlayerTapped extends Transcriber {
  @override
  writeToState() {
    int tapCount = manager.getStateValue(AppStateKey.SYMBOL_TAPPED_COUNT);
    DateTime lastTappedTime = manager.getStateValue(AppStateKey.SYMBOL_SHOWN_TIME);

    if(lastTappedTime != null){
      DateTime nowTappedTime = DateTime.now().toUtc();
      int reactionTime = nowTappedTime.difference(lastTappedTime).inMilliseconds;
      List<int> reactionTimes = manager.getStateValue(AppStateKey.REACTION_TIMES);
      reactionTimes.add(reactionTime);
      manager.updateState(AppStateKey.REACTION_TIMES, reactionTimes);
    }

    manager.updateState(AppStateKey.SYMBOL_TAPPED_COUNT, tapCount + 1);
    manager.updateState(AppStateKey.SYMBOL_SHOWN_TIME, DateTime.now().toUtc());
  }

}