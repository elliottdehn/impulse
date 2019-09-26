import 'package:flutter/widgets.dart';

import '../ScreenID.dart';

class ScreenChangeNotification extends Notification {
  final ScreenID screen;
  ScreenChangeNotification({this.screen});
}
