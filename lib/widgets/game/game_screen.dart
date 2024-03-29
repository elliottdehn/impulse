import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/experiments/refactor/model.dart';

import 'package:impulse/widgets/game/lives/lives_widget.dart';
import 'package:impulse/widgets/game/score/score_widget.dart';
import 'package:impulse/widgets/game/symbol/symbol_widget.dart';
import 'package:impulse/widgets/game/window/reaction_window_widget.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class GameScreen extends NotificationListener {
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
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20),
                    ScreenUtil().setHeight(statusBarHeight), 0, 0),
                child: ScoreWidget(m))),
        Container(
          alignment: Alignment.topRight,
          child: new Padding(
              padding: EdgeInsets.fromLTRB(
                  0, ScreenUtil().setHeight(statusBarHeight), 20, 0),
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
