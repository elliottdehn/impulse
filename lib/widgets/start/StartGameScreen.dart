import 'package:flutter/cupertino.dart';
import 'package:impulse/experiments/refactor/id/difficulty_id.dart';
import 'package:impulse/widgets/app/ScreenChangeNotification.dart';

import '../ScreenID.dart';

class StartGameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          ScreenChangeNotification(screen: ScreenID.GAME, difficultyID: DifficultyID.EASY).dispatch(context);
        },
        behavior: HitTestBehavior.opaque,
        child: Container(
            child: Center(child: Text("Tap anywhere to start playing!"))));
  }

}