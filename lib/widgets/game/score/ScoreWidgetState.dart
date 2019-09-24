import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/widgets/IPresenter.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';
import 'package:impulse/widgets/game/score/ScoreState.dart';

import 'ScoreWidget.dart';
import 'ScoreWidgetPresenter.dart';

class ScoreWidgetState extends State<ScoreWidget> implements IStateUpdateListener{

  int _score;
  IPresenter presenter;

  ScoreWidgetState(){
    presenter = ScoreWidgetPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _setState(presenter.initState() as ScoreState);
  }

  @override
  onStateUpdate(IState newState) {
    _setState(newState as ScoreState);
    _updateView();
  }

  _updateView(){
    setState(() {
    });
  }

  _setState(ScoreState s){
    _score = s.score;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
        "Score: $_score",
        style: Theme.of(context).textTheme.display1
            .apply(color: Color.fromRGBO(0, 0, 0, 1.0))
    );
  }

}