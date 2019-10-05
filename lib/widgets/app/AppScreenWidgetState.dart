import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:impulse/widgets/app/ScreenChangeNotification.dart';
import 'package:impulse/widgets/death/DeathScreen.dart';
import 'package:impulse/widgets/game/GameScreen.dart';
import 'package:impulse/widgets/start/StartGameScreen.dart';

import '../ScreenID.dart';
import 'AppScreenWidget.dart';

class AppScreenWidgetState extends State<AppScreenWidget> {
  ScreenID _screen;

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
          });
          return true; //cancel bubbling
        },
      ),
    );
  }

  Widget _getScreen() {
    switch (_screen) {
      case ScreenID.DEATH:
        return DeathScreen();
        break;
      case ScreenID.GAME:
        return GameScreen();
        break;
      case ScreenID.START:
        // TODO: Handle this case.
        return StartGameScreen();
        break;
    }
    throw Exception("Invalid screen: $_screen");
  }
}
