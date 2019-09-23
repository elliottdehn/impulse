import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/widgets/IPresenter.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';

import 'LivesState.dart';
import 'LivesWidget.dart';
import 'LivesWidgetPresenter.dart';

class LivesWidgetState extends State<LivesWidget> implements IStateUpdateListener {

  int _lives;
  IPresenter presenter;

  LivesWidgetState(){
    presenter = LivesWidgetPresenter(this);
  }

  @override
  initState(){
    super.initState();
    _setState(presenter.initState() as LivesState);
  }

  @override
  onStateUpdate(IState newState) {
    _setState(newState as LivesState);
    _updateState();
  }

  _updateState(){
    setState(() {
    });
  }

  _setState(LivesState s){
    _lives = s.lives;
  }

  @override
  Widget build(BuildContext context) {
    String livesString = "";
    for(var i = 0; i < _lives; i++){
      livesString += "♥";
    }
    return Text(
        livesString,
        style: Theme.of(context).textTheme.display1
            .apply(color: Color.fromRGBO(0, 0, 0, 1.0))
    );
  }
}