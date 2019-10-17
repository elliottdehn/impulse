import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/experiments/refactor/id/difficulty_id.dart';
import 'package:impulse/widgets/app/ScreenChangeNotification.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ScreenID.dart';

class StartGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 411, height: 843)..init(context);
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Stack(children: <Widget>[
      Padding(
          padding: EdgeInsets.fromLTRB(
              0, ScreenUtil().setHeight(statusBarHeight * 2), 0, 0),
          child: Container(
            alignment: Alignment.topCenter,
            child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Text(
                "welcome back to",
                style: TextStyle(fontSize: ScreenUtil().setSp(30)),
              ),
              Text(
                "IMPULSE!",
                style: TextStyle(fontSize: ScreenUtil().setSp(80)),
              ),
              SizedBox(height: ScreenUtil().setHeight(10)),
              Text(
                "🚫 Do not tap the X! 🚫",
                style: TextStyle(fontSize: ScreenUtil().setSp(30)),
              ),
              Text(
                "🔥 Do tap other letters! 🔥",
                style: TextStyle(fontSize: ScreenUtil().setSp(30)),
              ),
              Text(
                "⚡ Be fast! ⚡",
                style: TextStyle(fontSize: ScreenUtil().setSp(30)),
              )
            ]),
          )),
      Container(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Select Difficulty:",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                    fontWeight: FontWeight.bold)),
            SizedBox(height: ScreenUtil().setHeight(15)),
            RaisedButton(
              color: Colors.green[400],
              onPressed: () {
                ScreenChangeNotification(
                        screen: ScreenID.GAME, difficultyID: DifficultyID.EASY)
                    .dispatch(context);
              },
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(100),
                      ScreenUtil().setHeight(25),
                      ScreenUtil().setWidth(100),
                      ScreenUtil().setHeight(25)),
                  child: Text('🌱',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(40),
                          color: Colors.white))),
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            RaisedButton(
              color: Colors.yellow[400],
              onPressed: () {
                ScreenChangeNotification(
                        screen: ScreenID.GAME,
                        difficultyID: DifficultyID.MEDIUM)
                    .dispatch(context);
              },
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(100),
                      ScreenUtil().setHeight(25),
                      ScreenUtil().setWidth(100),
                      ScreenUtil().setHeight(25)),
                  child: Text('👍',
                      style: TextStyle(fontSize: ScreenUtil().setSp(40)))),
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            RaisedButton(
              color: Colors.red[400],
              onPressed: () {
                ScreenChangeNotification(
                        screen: ScreenID.GAME, difficultyID: DifficultyID.HARD)
                    .dispatch(context);
              },
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(100),
                      ScreenUtil().setHeight(25),
                      ScreenUtil().setWidth(100),
                      ScreenUtil().setHeight(25)),
                  child: Text('😡',
                      style: TextStyle(fontSize: ScreenUtil().setSp(40)))),
            ),
            SizedBox(height: ScreenUtil().setHeight(15)),
            RaisedButton(
              color: Colors.purple[400],
              onPressed: () {
                ScreenChangeNotification(
                        screen: ScreenID.GAME, difficultyID: DifficultyID.HERO)
                    .dispatch(context);
              },
              child: Padding(
                  padding: EdgeInsets.fromLTRB(
                      ScreenUtil().setWidth(100),
                      ScreenUtil().setHeight(25),
                      ScreenUtil().setWidth(100),
                      ScreenUtil().setHeight(25)),
                  child: Text('😈',
                      style: TextStyle(fontSize: ScreenUtil().setSp(40)))),
            ),
            SizedBox(height: statusBarHeight)
          ],
        ),
      )
    ]);
  }
}
