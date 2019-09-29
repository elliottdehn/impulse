import 'package:flutter/cupertino.dart';
import 'package:impulse/state/AppStateUpdateListener.dart';
import 'package:impulse/transcribers/impl/PlayerReactedTranscriber.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:impulse/widgets/IEventListener.dart';
import 'package:impulse/widgets/IStateUpdateHandler.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/transcribers/ITranscriber.dart';
import 'package:impulse/transcribers/impl/NewSymbolTranscriber.dart';
import 'package:impulse/widgets/IStateBuilder.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';
import 'package:impulse/widgets/game/symbol/SymbolStateBuilder.dart';

import '../../IPresenter.dart';

@immutable
class SymbolWidgetPresenter
    with AppStateUpdateListener
    implements IPresenter, IStateUpdateHandler, IEventListener {
  //view(ish)
  final IStateUpdateListener symbolWidgetState;
  //config
  final List<AppStateKey> keyListeners = [AppStateKey.SYMBOL];
  //transcribers
  final ITranscriber newSymbol = NewSymbolTranscriber();
  final ITranscriber playerReacted = PlayerReactedTranscriber();
  //state builder
  final IStateBuilder stateBuilder = SymbolStateBuilder();

  SymbolWidgetPresenter(this.symbolWidgetState) {
    listen(this);
    symbolWidgetState.onStateUpdate(stateBuilder.initState());
  }

  @override
  onEvent(EventID id) {
    if(EventID.PLAYER_REACTED == id){
      playerReacted.writeToState();
    } else if(EventID.NEW_SYMBOL == id){
      newSymbol.writeToState();
    } else if(EventID.DISPOSE == id){
      unsubscribe(this);
    } else {
      throw Exception("Invalid event");
    }
  }

  @override
  void onModelChanged(AppStateKey key, value) {
    if (key == AppStateKey.SYMBOL) {
      symbolWidgetState.onStateUpdate(stateBuilder.buildState());
    }
  }

  @override
  bool shouldNotifyForKeyStateChange(AppStateKey key) {
    return keyListeners.contains(key);
  }

}
