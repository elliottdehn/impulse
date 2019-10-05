import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impulse/widgets/app/ScreenChangeNotification.dart';

import '../ScreenID.dart';

class DeathScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          ScreenChangeNotification(screen: ScreenID.GAME).dispatch(context);
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
            child: Center(child: Text("Tap anywhere to play again!"))));
  }
}

/*
              onPressed: () {
                ScreenChangeNotification(screen: ScreenID.GAME)
                    .dispatch(context);
              }
 */
