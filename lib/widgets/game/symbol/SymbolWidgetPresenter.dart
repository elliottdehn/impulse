import 'package:flutter/cupertino.dart';
import 'package:impulse/state/AppStateUpdateListener.dart';
import 'package:impulse/transcribers/impl/TranscriberPlayerReacted.dart';
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
  final ITranscriber playerReacted = TranscriberPlayerReacted();
  //state builder
  final IStateBuilder stateBuilder = SymbolStateBuilder();

  SymbolWidgetPresenter(this.symbolWidgetState) {
    listen(this);
  }

  @override
  onEvent(EventID id) {
    if(EventID.PLAYER_REACTED == id){
      playerReacted.writeToState();
    } else if(EventID.NEW_SYMBOL == id){
      newSymbol.writeToState();
    } else {
      throw Exception("Invalid event ID for Symbol Presenter: $id");
    }
  }

  //TODO: Finish out the animation view
  //TODO: Add presenters and handle events for Game screen and Death screen

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
