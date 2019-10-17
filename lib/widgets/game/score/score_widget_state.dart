import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/experiments/refactor/id/event_id.dart';
import 'package:impulse/widgets/i_view_state.dart';
import 'package:impulse/widgets/i_view.dart';
import 'package:impulse/widgets/game/score/score_state.dart';

import 'score_widget.dart';
import 'score_widget_presenter.dart';

class ScoreWidgetState extends State<ScoreWidget> implements IView {
  int _score;
  ScoreWidgetPresenter presenter;
  bool created = false;

  ScoreWidgetState(Model m) {
    presenter = ScoreWidgetPresenter(m, this);
  }

  @override
  onStateUpdate(IViewState newState) {
    _setState(newState as ScoreState);
    if (created) {
      //widget not yet created
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
