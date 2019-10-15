import 'package:flutter/cupertino.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/state/state_update_listener.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:impulse/widgets/IEventListener.dart';
import 'package:impulse/widgets/IStateUpdateHandler.dart';
import 'package:impulse/widgets/IPresenter.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateBuilder.dart';
import 'package:impulse/widgets/i_view.dart';
import 'package:impulse/widgets/game/lives/LivesStateBuilder.dart';

@immutable
class LivesWidgetPresenter
    with StateUpdateListener
    implements IPresenter, IStateUpdateHandler, IEventListener {

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
    if(EventID.DISPOSE == id){
      unsubscribe(this);
    }
  }

}
