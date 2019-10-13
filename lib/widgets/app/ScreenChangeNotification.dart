import 'package:flutter/widgets.dart';
import 'package:impulse/experiments/refactor/id/difficulty_id.dart';

import '../ScreenID.dart';

class ScreenChangeNotification extends Notification {
  final ScreenID screen;
  final DifficultyID difficultyID;
  ScreenChangeNotification({this.screen, this.difficultyID});
}
