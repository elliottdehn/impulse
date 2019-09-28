import 'package:flutter/cupertino.dart';
import 'package:impulse/widgets/IPresenter.dart';
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

  final double _baseHeight = 60;

  IPresenter stateUpdater;

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
    _controller.forward();
  }

  @override
  onStateUpdate(IState newState) {
    ReactionWindowState state = newState as ReactionWindowState;
    _baseReactionWindow = state.baseReactionWindow;
    _currReactionWindow = state.currReactionWindow;

    _controller.stop(canceled: state.isStopped);
    if(state.isReset) {
      _controller.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
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
    super.dispose();
  }

}