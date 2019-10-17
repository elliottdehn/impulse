import 'package:flutter/cupertino.dart';
import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/state/state_update_listener.dart';
import 'package:impulse/widgets/i_event_listener.dart';
import 'package:impulse/widgets/i_state_update_handler.dart';
import 'package:impulse/widgets/i_view.dart';
import 'package:impulse/widgets/game/score/score_state_builder.dart';

import '../../../experiments/refactor/id/event_id.dart';
import 'score_state.dart';

@immutable
class ScoreWidgetPresenter
    with StateUpdateListener
    implements IStateUpdateHandler, IEventListener {
  final ScoreStateBuilder stateBuilder = ScoreStateBuilder();
  final IView stateUpdateListener;

  final Model m;

  ScoreWidgetPresenter(this.m, this.stateUpdateListener) {
    listen(this);
    stateUpdateListener.onStateUpdate(stateBuilder.initState(m.readState()));
  }

  @override
  void onModelChanged(StateValues s) async {
    ScoreState state = ScoreState();
    state.score = ~s.get(ValueID.SCORE);
    stateUpdateListener.onStateUpdate(state);
  }

  @override
  onEvent(EventID id) async {
    if (EventID.DISPOSE == id) {
      unsubscribe(this);
    }
  }
}
