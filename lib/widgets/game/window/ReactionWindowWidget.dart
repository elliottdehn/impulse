import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReactionWindowWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ReactionWindowState();
}

class ReactionWindowState extends State<ReactionWindowWidget>
    with SingleTickerProviderStateMixin {
  //TODO Set up this widget to work correctly

  Animation<double> _animation;
  AnimationController _controller;

  final int _baseReactionWindow = 700;
  int _currReactionWindow;

  final double _baseHeight = 60;

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

  double _getWidthScalar() {
    return _animation.value * (_currReactionWindow / _baseReactionWindow);
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
