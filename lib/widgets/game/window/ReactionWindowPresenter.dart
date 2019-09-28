import 'package:flutter/cupertino.dart';
import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/score/ScoreOracle.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/state/AppStateUpdateListener.dart';
import 'package:impulse/widgets/IStateUpdateHandler.dart';
import 'package:impulse/widgets/IPresenter.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';
import 'package:impulse/widgets/game/window/ReactionWindowStateBuilder.dart';

import 'ReactionWindowState.dart';

@immutable
class ReactionWindowPresenter
    with AppStateUpdateListener
    implements IPresenter, IStateUpdateHandler {
  final ReactionWindowStateBuilder stateBuilder = ReactionWindowStateBuilder();
  final IOracle currentScore = ScoreOracle();
  final IStateUpdateListener stateListener;
  final List<AppStateKey> stateKeyListeners = [
    AppStateKey.SYMBOL_TAPPED_COUNT,
    AppStateKey.SYMBOL
  ];

  ReactionWindowPresenter(this.stateListener) {
    listen(this);
  }

  @override
  void onModelChanged(AppStateKey key, value) {
    ReactionWindowState state = ReactionWindowState();
    if (shouldNotifyForKeyStateChange(key)) {
      state = stateBuilder.buildState();
      stateListener.onStateUpdate(state);
    }
  }

  @override
  bool shouldNotifyForKeyStateChange(AppStateKey key) {
    return stateKeyListeners.contains(key);
  }
}
