import 'package:flutter/cupertino.dart';
import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/experiments/values.dart';
import 'package:impulse/state/state_update_listener.dart';
import 'package:impulse/experiments/refactor/id/event_id.dart';
import 'package:impulse/widgets/i_state_update_handler.dart';
import 'package:impulse/widgets/i_view.dart';
import 'package:impulse/widgets/game/window/reaction_window_state_builder.dart';

import '../../i_event_listener.dart';
import 'reaction_window_state.dart';

@immutable
class ReactionWindowPresenter
    with StateUpdateListener
    implements IStateUpdateHandler, IEventListener {
  final ReactionWindowStateBuilder stateBuilder = ReactionWindowStateBuilder();
  final IView stateUpdateListener;

  final Model m;

  ReactionWindowPresenter(this.m, this.stateUpdateListener) {
    listen(this);
    stateUpdateListener.onStateUpdate(stateBuilder.initState(m.readState()));
  }

  @override
  onEvent(EventID id) async {
    if (EventID.ENFORCE_TAP == id) {
      m.onEvent(Event(EventID.ENFORCE_TAP));
    } else if (EventID.DISPOSE == id) {
      unsubscribe(this);
    }
  }

  @override
  void onModelChanged(StateValues newState) async {
    ReactionWindowState state = stateBuilder.buildState(newState);
    if (EventID.PLAYER_REACTED == ~newState.get(ValueID.LAST_EVENT)) {
      state.isStopped = true;
      state.isReset = false;
      stateUpdateListener.onStateUpdate(state);
    } else if (EventID.NEW_SYMBOL == ~newState.get(ValueID.LAST_EVENT)) {
      state.isStopped = false;
      state.isReset = true;
      stateUpdateListener.onStateUpdate(state);
    }
  }
}
