import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/experiments/refactor/model.dart';

import 'package:impulse/widgets/game/lives/LivesWidget.dart';
import 'package:impulse/widgets/game/score/ScoreWidget.dart';
import 'package:impulse/widgets/game/symbol/SymbolWidget.dart';
import 'package:impulse/widgets/game/window/ReactionWindowWidget.dart';

class GameScreen extends NotificationListener {

  //This is mostly just to invert the dependency a little bit

  final Model m;

  GameScreen(this.m);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Stack(
      children: <Widget>[
        Container(
            alignment: Alignment.bottomCenter, child: ReactionWindowWidget(m)),
        Container(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.fromLTRB(20, statusBarHeight, 0, 0),
                child: ScoreWidget(m))),
        Container(
          alignment: Alignment.topRight,
          child: new Padding(
              padding: EdgeInsets.fromLTRB(0, statusBarHeight, 20, 0),
              child: LivesWidget(m)),
        ),
        Container(
          alignment: Alignment.center,
          child: SymbolWidget(m),
        )
      ],
    );
  }
}
