import 'package:flutter/cupertino.dart';
import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/state/state_update_listener.dart';
import 'package:impulse/widgets/IEventListener.dart';
import 'package:impulse/widgets/IStateUpdateHandler.dart';
import 'package:impulse/widgets/IPresenter.dart';
import 'package:impulse/widgets/i_view.dart';
import 'package:impulse/widgets/game/score/ScoreStateBuilder.dart';

import '../../EventID.dart';
import 'ScoreState.dart';

@immutable
class ScoreWidgetPresenter
    with StateUpdateListener
    implements IPresenter, IStateUpdateHandler, IEventListener {
  final ScoreStateBuilder stateBuilder = ScoreStateBuilder();
  final IView stateUpdateListener;

  final Model m;

  ScoreWidgetPresenter(this.m, this.stateUpdateListener) {
    listen(this);
    stateUpdateListener.onStateUpdate(stateBuilder.initState(m.readState()));
  }

  @override
  void onModelChanged(StateValues s) {
    ScoreState state = ScoreState();
    state.score = ~s.get(ValueID.SCORE);
    stateUpdateListener.onStateUpdate(state);
  }

  @override
  onEvent(EventID id) {
    if(EventID.DISPOSE == id){
      unsubscribe(this);
    }
  }
}
