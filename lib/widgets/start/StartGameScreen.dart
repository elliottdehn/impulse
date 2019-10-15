import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/experiments/refactor/id/difficulty_id.dart';
import 'package:impulse/widgets/app/ScreenChangeNotification.dart';

import '../ScreenID.dart';

class StartGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Stack(children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(0, statusBarHeight * 2, 0, 0),
          child: Container(
        alignment: Alignment.topCenter,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "welcome back to",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "IMPULSE!",
                style: TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 30),
              Text(
                "🚫 Do not tap the X! 🚫",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                "🔥 Do tap other letters! 🔥",
                style: TextStyle(fontSize: 30),
              )
            ]),
      )),
      Container(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            RaisedButton(
              color: Colors.green[400],
              onPressed: () {
                ScreenChangeNotification(
                    screen: ScreenID.GAME, difficultyID: DifficultyID.EASY)
                    .dispatch(context);
              },
              child:
              Text('🌱', style: TextStyle(fontSize: 40, color: Colors.white)),
            ),
            const SizedBox(height: 30),
            RaisedButton(
              color: Colors.yellow[400],
              onPressed: () {
                ScreenChangeNotification(
                    screen: ScreenID.GAME, difficultyID: DifficultyID.MEDIUM)
                    .dispatch(context);
              },
              child: const Text('👍', style: TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: 30),
            RaisedButton(
              color: Colors.red[400],
              onPressed: () {
                ScreenChangeNotification(
                    screen: ScreenID.GAME, difficultyID: DifficultyID.HARD)
                    .dispatch(context);
              },
              child: const Text('😡', style: TextStyle(fontSize: 40)),
            ),
            const SizedBox(height: 30),
            RaisedButton(
              color: Colors.purple[400],
              onPressed: () {
                ScreenChangeNotification(
                    screen: ScreenID.GAME, difficultyID: DifficultyID.HERO)
                    .dispatch(context);
              },
              child: const Text('😈', style: TextStyle(fontSize: 40)),
            ),
            SizedBox(height: statusBarHeight * 2)
          ],
        ),
      )
    ]);
  }
}
