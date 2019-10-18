import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/experiments/refactor/id/difficulty_id.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/experiments/values.dart';
import 'package:impulse/experiments/refactor/id/event_id.dart';
import 'package:impulse/widgets/app/screen_change_notification.dart';
import 'package:impulse/widgets/death/death_screen.dart';
import 'package:impulse/widgets/game/game_screen.dart';
import 'package:impulse/widgets/start/start_game_screen.dart';

import '../../experiments/refactor/id/screen_id.dart';
import 'app_screen_widget.dart';

class AppScreenWidgetState extends State<AppScreenWidget> {
  ScreenID _screen;
  Difficulty _difficulty;
  Model m;

  @override
  void initState() {
    _screen = ScreenID.START;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<ScreenChangeNotification>(
        child: _getScreen(),
        onNotification: (notification) {
          setState(() {
            _screen = notification.screen;
            if (notification.difficultyID != null) {
              _difficulty = Difficulty(notification.difficultyID);
            }
          });
          return true; //cancel bubbling
        },
      ),
    );
  }

  //I am aware of the navigator. I made this early on and it is extremely
  //difficult to change it without changing the entire app.
  //It works, so I'll ship it.
  Widget _getScreen() {
    switch (_screen) {
      case ScreenID.DEATH:
        return DeathScreen(m);
        break;
      case ScreenID.GAME:
        m = Model(_difficulty);
        return GameScreen(m);
        break;
      case ScreenID.START:
        return StartGameScreen();
        break;
    }
    throw Exception("Invalid screen: $_screen");
  }
}
