import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/score/ScoreOracle.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/state/IAppStateListener.dart';
import 'package:impulse/widgets/IPresenter.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';
import 'package:impulse/widgets/game/score/ScoreStateBuilder.dart';

import 'ScoreState.dart';

class ScoreWidgetPresenter implements IPresenter, IAppStateListener{

  final ScoreStateBuilder stateBuilder = ScoreStateBuilder();
  final IOracle currentScore = ScoreOracle();
  final IStateUpdateListener stateListener;
  final List<AppStateKey> stateKeyListeners =
  [AppStateKey.NORMAL_SYMBOL_TOTAL, AppStateKey.KILLER_SYMBOL_TOTAL];

  ScoreWidgetPresenter(this.stateListener);

  @override
  IState initState() {
    return stateBuilder.initState();
  }

  @override
  void onModelChanged(AppStateKey key, value) {
    ScoreState state = ScoreState();
    if(AppStateKey.NORMAL_SYMBOL_TOTAL == key ||
        AppStateKey.KILLER_SYMBOL_TOTAL == key) {
      state.score = currentScore.getAnswer();
    }
  }

  @override
  bool shouldNotifyForKeyStateChange(AppStateKey key) {
    return stateKeyListeners.contains(key);
  }

}