import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';
import 'package:impulse/widgets/game/window/ReactionWindowPresenter.dart';
import 'package:impulse/widgets/game/window/ReactionWindowState.dart';

import 'ReactionWindowWidget.dart';

class ReactionWindowWidgetState extends State<ReactionWindowWidget>
    with SingleTickerProviderStateMixin implements IStateUpdateListener {

  Animation<double> _animation;
  AnimationController _controller;
  int _baseReactionWindow;
  int _currReactionWindow;
  Timer windowEnforcement;

  final double _baseHeight = 60;

  ReactionWindowPresenter stateUpdater;
  bool created = false;

  ReactionWindowWidgetState(){
    stateUpdater = new ReactionWindowPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _currReactionWindow = _baseReactionWindow;
    _controller = AnimationController(
        duration: Duration(milliseconds: _currReactionWindow), vsync: this);
    _animation = Tween<double>(begin: 1.0, end: 0).animate(_controller);
    _animation.addListener(() {
      setState(() {
        //animation changed
      });
    });
  }

  @override
  onStateUpdate(IState newState) {
    ReactionWindowState state = newState as ReactionWindowState;

    if(!created) {
      _baseReactionWindow = state.baseReactionWindow;
      _currReactionWindow = state.currReactionWindow;
      return;
    }

    if(windowEnforcement == null && !state.isStopped) {
      _controller.forward(); //run the controller
      windowEnforcement = new Timer(
          Duration(milliseconds: _currReactionWindow), () =>
          _onEnforceWindow());
    } else if (windowEnforcement != null && !windowEnforcement.isActive && state.isReset) {
      _controller.reset();
      _controller.forward(); //run the controller
      windowEnforcement = new Timer(
          Duration(milliseconds: _currReactionWindow), () =>
          _onEnforceWindow());
    }

    if(state.isStopped != null && state.isStopped) {
      _controller.stop();
    }
  }

  _onEnforceWindow(){
    stateUpdater.onEvent(EventID.ENFORCE_TAP);
  }

  @override
  Widget build(BuildContext context) {
    created = true;
    return Container(
        height: _baseHeight,
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(255, 255, 255, 0.0),
        child: FractionallySizedBox(
          alignment: Alignment.center,
          heightFactor: 1,
          widthFactor: _getWidthScalar(),
          child: Container(color: Color.fromRGBO(0, 0, 0, 1.0)),
        ));
  }

  double _getWidthScalar() {
    return _animation.value * (_currReactionWindow / _baseReactionWindow);
  }

  @override
  void dispose() {
    _controller.dispose();
    windowEnforcement.cancel();
    stateUpdater.onEvent(EventID.DISPOSE);
    super.dispose();
  }

}