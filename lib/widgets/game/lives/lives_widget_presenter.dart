import 'package:flutter/cupertino.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/state/state_update_listener.dart';
import 'package:impulse/experiments/refactor/id/event_id.dart';
import 'package:impulse/widgets/i_event_listener.dart';
import 'package:impulse/widgets/i_state_update_handler.dart';
import 'package:impulse/widgets/i_view_state.dart';
import 'package:impulse/widgets/i_state_builder.dart';
import 'package:impulse/widgets/i_view.dart';
import 'package:impulse/widgets/game/lives/lives_state_builder.dart';

@immutable
class LivesWidgetPresenter
    with StateUpdateListener
    implements IStateUpdateHandler, IEventListener {
  final IStateBuilder stateBuilder = LivesStateBuilder();

  final IView stateUpdateListener;
  final Model m;

  LivesWidgetPresenter(this.m, this.stateUpdateListener) {
    listen(this);
    stateUpdateListener.onStateUpdate(stateBuilder.initState(m.readState()));
  }

  @override
  void onModelChanged(StateValues s) async {
    IViewState newState = stateBuilder.buildState(s);
    stateUpdateListener.onStateUpdate(newState);
  }

  @override
  onEvent(EventID id) async {
    if (EventID.DISPOSE == id) {
      unsubscribe(this);
    }
  }
}
