import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/widgets/IState.dart';

import '../../StateBuilder.dart';
import 'LivesState.dart';

class LivesStateBuilder extends StateBuilder {

  @override
  IState buildState() {
    LivesState ls = LivesState();
    ls.lives = manager.getStateValue(AppStateKey.LIVES);
    return ls;
  }

  @override
  IState initState() {
    LivesState ls = LivesState();
    ls.lives = manager.getConfigValue(AppConfigKey.LIVES_START);
    return ls;
  }

}