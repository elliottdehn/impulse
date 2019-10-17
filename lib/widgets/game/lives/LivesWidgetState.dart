import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/i_view.dart';
import 'package:impulse/widgets/ScreenID.dart';
import 'package:impulse/widgets/app/ScreenChangeNotification.dart';

import 'LivesState.dart';
import 'LivesWidget.dart';
import 'LivesWidgetPresenter.dart';

class LivesWidgetState extends State<LivesWidget> with WidgetsBindingObserver
    implements IView {
  int _lives;
  LivesWidgetPresenter presenter;
  bool created = false;

  LivesWidgetState(Model m) {
    presenter = LivesWidgetPresenter(m, this);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state.index != null){
      ScreenChangeNotification(screen: ScreenID.DEATH).dispatch(context);
    }
  }

  @override
  onStateUpdate(IViewState newState) {
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
      livesString += "❤";
    }
    return Text(livesString,
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
