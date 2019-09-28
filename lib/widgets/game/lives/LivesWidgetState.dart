import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/widgets/IPresenter.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';
import 'package:impulse/widgets/ScreenID.dart';
import 'package:impulse/widgets/app/ScreenChangeNotification.dart';

import 'LivesState.dart';
import 'LivesWidget.dart';
import 'LivesWidgetPresenter.dart';

class LivesWidgetState extends State<LivesWidget>
    implements IStateUpdateListener {
  int _lives;
  IPresenter presenter;
  bool created = false;

  LivesWidgetState() {
    presenter = LivesWidgetPresenter(this);
  }

  @override
  onStateUpdate(IState newState) {
    LivesState livesState = newState as LivesState;
    _setState(livesState);
    if(created && _lives != null && _lives != 0) {
      _updateState();
    } else if (created && _lives != null && _lives == 0) {
      ScreenChangeNotification(screen: ScreenID.DEATH).dispatch(context);
    }
  }

  _updateState() {
    setState(() {});
  }

  _setState(LivesState s) {
    _lives = s.lives;
  }

  @override
  Widget build(BuildContext context) {
    created = true;

    String livesString = "";
    for (var i = 0; i < _lives; i++) {
      livesString += "♥";
    }
    return Text(livesString,
        style: Theme.of(context)
            .textTheme
            .display1
            .apply(color: Color.fromRGBO(0, 0, 0, 1.0)));
  }
}
