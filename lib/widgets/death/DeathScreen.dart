import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/widgets/app/ScreenChangeNotification.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ScreenID.dart';

class DeathScreen extends StatelessWidget {
  final Model m;

  const DeathScreen(this.m);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    List<int> reactionTimes = ~m.readState().get(ValueID.REACTION_TIMES);
    int reactionLength = reactionTimes.length;
    String reactionLine = "";
    if(reactionLength > 0) {
      int reactionTotal = reactionTimes.reduce((value, element) =>
      value + element);
      int reactionAvg = (reactionTotal / reactionLength).round();
      reactionLine = "⚡$reactionAvg ms⚡";
    } else {
      reactionLine = "👎";
    }

    return Stack(children: <Widget>[
      GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            ScreenChangeNotification(screen: ScreenID.GAME).dispatch(context);
          },
          child: SizedBox.expand(child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    "💀",
                    style: TextStyle(fontSize: ScreenUtil().setSp(120)),
                  )),
              SizedBox(height: ScreenUtil().setHeight(30)),
              Text(
                "🔥" + (~m.readState().get(ValueID.SCORE)).toString() + "🔥",
                style: TextStyle(fontSize: ScreenUtil().setSp(60)),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              Text(
                reactionLine,
                style: TextStyle(fontSize: ScreenUtil().setSp(60)),
              ),
              SizedBox(height: ScreenUtil().setHeight(30)),
              Text(
                "Tap anywhere to play again!",
                style: TextStyle(fontSize: ScreenUtil().setSp(30)),
              ),
            ],
          ))),
      Container(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: EdgeInsets.fromLTRB(0, ScreenUtil().setHeight(statusBarHeight), 0, 0),
              child: RaisedButton(
                color: Color.fromRGBO(0, 0, 0, 1.0),
                onPressed: () {
                  ScreenChangeNotification(screen: ScreenID.START)
                      .dispatch(context);
                },
                child: Text('ESCAPE',
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(40),
                        color: Color.fromRGBO(255, 255, 255, 1.0))),
              )))
    ]);
  }
}

/*
              onPressed: () {
                ScreenChangeNotification(screen: ScreenID.GAME)
                    .dispatch(context);
              }
 */
