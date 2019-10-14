import 'package:flutter/cupertino.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/score/ScoreOracle.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/state/AppStateUpdateListener.dart';
import 'package:impulse/widgets/IEventListener.dart';
import 'package:impulse/widgets/IStateUpdateHandler.dart';
import 'package:impulse/widgets/IPresenter.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';
import 'package:impulse/widgets/game/score/ScoreStateBuilder.dart';

import '../../EventID.dart';
import 'ScoreState.dart';

@immutable
class ScoreWidgetPresenter
    with AppStateUpdateListener
    implements IPresenter, IStateUpdateHandler, IEventListener {
  final ScoreStateBuilder stateBuilder = ScoreStateBuilder();
  final IOracle currentScore = ScoreOracle();
  final IView stateUpdateListener;
  final List<AppStateKey> stateKeyListeners = [
    AppStateKey.NORMAL_SYMBOL_TOTAL,
    AppStateKey.KILLER_SYMBOL_TOTAL
  ];

  final Model m;

  ScoreWidgetPresenter(this.m, this.stateUpdateListener) {
    listen(this);
    stateUpdateListener.onStateUpdate(stateBuilder.initState());
  }

  @override
  void onModelChanged(AppStateKey key, value) {
    ScoreState state = ScoreState();
    if (AppStateKey.NORMAL_SYMBOL_TOTAL == key ||
        AppStateKey.KILLER_SYMBOL_TOTAL == key) {
      state.score = currentScore.getAnswer();
      stateUpdateListener.onStateUpdate(state);
    }
  }

  @override
  bool shouldNotifyForKeyStateChange(AppStateKey key) {
    return stateKeyListeners.contains(key);
  }

  @override
  onEvent(EventID id) {
    if(EventID.DISPOSE == id){
      unsubscribe(this);
    }
  }
}
