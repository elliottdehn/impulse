import 'package:flutter/cupertino.dart';
import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/score/ScoreOracle.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/state/AppStateUpdateListener.dart';
import 'package:impulse/transcribers/ITranscriber.dart';
import 'package:impulse/transcribers/impl/EnforceWindowTranscriber.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:impulse/widgets/IStateBuilder.dart';
import 'package:impulse/widgets/IStateUpdateHandler.dart';
import 'package:impulse/widgets/IPresenter.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';
import 'package:impulse/widgets/game/window/ReactionWindowStateBuilder.dart';

import '../../IEventListener.dart';
import '../../IState.dart';
import 'ReactionWindowState.dart';

@immutable
class ReactionWindowPresenter
    with AppStateUpdateListener
    implements IPresenter, IStateUpdateHandler, IEventListener  {
  final ReactionWindowStateBuilder stateBuilder = ReactionWindowStateBuilder();
  final IOracle currentScore = ScoreOracle();
  final ITranscriber enforceWindow = EnforceWindowTranscriber();
  final IStateBuilder windowStateBuilder = ReactionWindowStateBuilder();
  final IStateUpdateListener stateUpdateListener;
  final List<AppStateKey> stateKeyListeners = [
    AppStateKey.SYMBOL_TAPPED_COUNT,
    AppStateKey.SYMBOL
  ];

  ReactionWindowPresenter(this.stateUpdateListener) {
    listen(this);
    stateUpdateListener.onStateUpdate(stateBuilder.initState());
  }

  @override
  void onModelChanged(AppStateKey key, value) {
    ReactionWindowState state = ReactionWindowState();
    if (shouldNotifyForKeyStateChange(key)) {
      state = stateBuilder.buildState();
      stateUpdateListener.onStateUpdate(state);
    }
  }

  @override
  bool shouldNotifyForKeyStateChange(AppStateKey key) {
    return stateKeyListeners.contains(key);
  }

  @override
  onEvent(EventID id) {
    if(EventID.ENFORCE_TAP == id){
      enforceWindow.writeToState();
      IState state = windowStateBuilder.buildState();
      stateUpdateListener.onStateUpdate(state);
    }
  }
}
