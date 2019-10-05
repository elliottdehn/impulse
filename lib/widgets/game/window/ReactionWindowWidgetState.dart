import 'package:flutter/cupertino.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';
import 'package:impulse/widgets/game/window/ReactionWindowPresenter.dart';
import 'package:impulse/widgets/game/window/ReactionWindowState.dart';

import 'ReactionWindowWidget.dart';

class ReactionWindowWidgetState extends State<ReactionWindowWidget>
    with SingleTickerProviderStateMixin implements IStateUpdateListener {

  Widget animatedObject = Container(color: Color.fromRGBO(0, 0, 0, 1.0));
  Animation<double> _animation;
  AnimationController _controller;
  int _baseReactionWindow;
  int _currReactionWindow;

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

    _animation.addStatusListener((status)
    {
      if(status == AnimationStatus.completed){
        _onEnforceWindow();
      }
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

    if(!state.isStopped || state.isReset) {
      _controller.reset();
      _controller.forward(); //run the controller
    } else if(state.isStopped) {
      _controller.stop(canceled: false);
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
          child: animatedObject),
        );
  }

  double _getWidthScalar() {
    return _animation.value * (_currReactionWindow / _baseReactionWindow);
  }

  @override
  void dispose() {
    _controller.dispose();
    stateUpdater.onEvent(EventID.DISPOSE);
    super.dispose();
  }

}