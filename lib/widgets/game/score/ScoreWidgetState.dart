import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:impulse/widgets/IPresenter.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';
import 'package:impulse/widgets/game/score/ScoreState.dart';

import 'ScoreWidget.dart';
import 'ScoreWidgetPresenter.dart';

class ScoreWidgetState extends State<ScoreWidget>
    implements IStateUpdateListener {
  int _score;
  ScoreWidgetPresenter presenter;
  bool created = false;

  ScoreWidgetState(Model m) {
    presenter = ScoreWidgetPresenter(this);
  }

  @override
  onStateUpdate(IState newState) {
    _setState(newState as ScoreState);
    if(created) { //widget not yet created
      _updateView();
    }
  }

  _updateView() {
    setState(() {});
  }

  _setState(ScoreState s) {
    _score = s.score;
  }

  @override
  Widget build(BuildContext context) {
    created = true;
    return Text("🔥$_score",
        style: Theme.of(context)
            .textTheme
            .display1
            .apply(color: Color.fromRGBO(0, 0, 0, 1.0)));
  }

  @override
  void dispose() {
    presenter.onEvent(EventID.DISPOSE);
    super.dispose();
  }
}
