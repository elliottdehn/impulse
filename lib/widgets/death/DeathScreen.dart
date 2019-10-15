import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/widgets/app/ScreenChangeNotification.dart';

import '../ScreenID.dart';

class DeathScreen extends StatelessWidget {
  final Model m;

  const DeathScreen(this.m);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Stack(children: <Widget>[
      GestureDetector(
          onTap: () {
            ScreenChangeNotification(screen: ScreenID.GAME).dispatch(context);
          },
          child: Container(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding:
                          EdgeInsets.fromLTRB(0, statusBarHeight * 2, 0, 0),
                      child: Text(
                        "💀",
                        style: TextStyle(fontSize: 120),
                      )),
                  const SizedBox(height: 30),
                  Text(
                    "🔥 " +
                        (~m.readState().get(ValueID.SCORE)).toString() +
                        " 🔥",
                    style: TextStyle(fontSize: 60),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Tap anywhere to play again!",
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ))),
      Container(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, statusBarHeight),
              child: RaisedButton(
            color: Color.fromRGBO(0, 0, 0, 1.0),
            onPressed: () {
              ScreenChangeNotification(screen: ScreenID.START)
                  .dispatch(context);
            },
            child: const Text('GIVE UP NOW',
                style: TextStyle(
                    fontSize: 40, color: Color.fromRGBO(255, 255, 255, 1.0))),
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
