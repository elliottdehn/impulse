import 'package:flutter/widgets.dart';
import 'package:impulse/experiments/refactor/id/difficulty_id.dart';

import '../../experiments/refactor/id/screen_id.dart';

class ScreenChangeNotification extends Notification {
  final ScreenID screen;
  final DifficultyID difficultyID;
  ScreenChangeNotification({this.screen, this.difficultyID});
}
