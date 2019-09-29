import 'package:flutter/cupertino.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/state/AppStateUpdateListener.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:impulse/widgets/IEventListener.dart';
import 'package:impulse/widgets/IStateUpdateHandler.dart';
import 'package:impulse/widgets/IPresenter.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateBuilder.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';
import 'package:impulse/widgets/game/lives/LivesStateBuilder.dart';

@immutable
class LivesWidgetPresenter
    with AppStateUpdateListener
    implements IPresenter, IStateUpdateHandler, IEventListener {
  final IStateBuilder stateBuilder = LivesStateBuilder();
  final List<AppStateKey> keyListeners = [AppStateKey.LIVES];
  final IStateUpdateListener stateUpdateListener;

  LivesWidgetPresenter(this.stateUpdateListener) {
    listen(this);
    stateUpdateListener.onStateUpdate(stateBuilder.initState());
  }

  @override
  void onModelChanged(AppStateKey key, value) {
    if (AppStateKey.LIVES == key) {
      IState newState = stateBuilder.buildState();
      stateUpdateListener.onStateUpdate(newState);
    }
  }

  @override
  bool shouldNotifyForKeyStateChange(AppStateKey key) {
    return keyListeners.contains(key);
  }

  @override
  onEvent(EventID id) {
    if(EventID.DISPOSE == id){
      unsubscribe(this);
    }
  }

}
