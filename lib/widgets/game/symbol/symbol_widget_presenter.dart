import 'package:flutter/cupertino.dart';
import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/experiments/values.dart';
import 'package:impulse/state/state_update_listener.dart';
import 'package:impulse/experiments/refactor/id/event_id.dart';
import 'package:impulse/widgets/i_event_listener.dart';
import 'package:impulse/widgets/i_state_update_handler.dart';
import 'package:impulse/widgets/i_state_builder.dart';
import 'package:impulse/widgets/i_view.dart';
import 'package:impulse/widgets/game/symbol/symbol_state_builder.dart';

@immutable
class SymbolWidgetPresenter
    with StateUpdateListener
    implements IStateUpdateHandler, IEventListener {
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
    if (EventID.PLAYER_REACTED == id) {
      m.onEvent(Event(EventID.PLAYER_REACTED));
    } else if (EventID.NEW_SYMBOL == id) {
      m.onEvent(Event(EventID.NEW_SYMBOL));
    } else if (EventID.DISPOSE == id) {
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
