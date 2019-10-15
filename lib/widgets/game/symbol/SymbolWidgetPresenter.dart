import 'package:flutter/cupertino.dart';
import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/experiments/values.dart';
import 'package:impulse/state/state_update_listener.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:impulse/widgets/IEventListener.dart';
import 'package:impulse/widgets/IStateUpdateHandler.dart';
import 'package:impulse/widgets/IStateBuilder.dart';
import 'package:impulse/widgets/i_view.dart';
import 'package:impulse/widgets/game/symbol/SymbolStateBuilder.dart';

import '../../IPresenter.dart';

@immutable
class SymbolWidgetPresenter
    with StateUpdateListener
    implements IPresenter, IStateUpdateHandler, IEventListener {
  //view(ish)
  final IView symbolWidgetState;
  //state builder
  final IStateBuilder stateBuilder = SymbolStateBuilder();

  final Model m;

  SymbolWidgetPresenter(this.m, this.symbolWidgetState) {
    listen(this);
    symbolWidgetState.onStateUpdate(stateBuilder.initState(m.readState()));
  }

  @override
  onEvent(EventID id) async {
    if(EventID.PLAYER_REACTED == id){
      m.onEvent(Event(EventID.PLAYER_REACTED));
    } else if(EventID.NEW_SYMBOL == id){
      m.onEvent(Event(EventID.NEW_SYMBOL));
    } else if(EventID.DISPOSE == id){
      unsubscribe(this);
    }
  }

  @override
  void onModelChanged(StateValues s) async {
    if (EventID.NEW_SYMBOL == ~s.get(ValueID.LAST_EVENT)) {
      symbolWidgetState.onStateUpdate(stateBuilder.buildState(s));
    }
  }

}
