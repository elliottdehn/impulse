import 'package:impulse/state/AppStateManager.dart';
import 'package:impulse/state/IAppStateManager.dart';

import 'IState.dart';

abstract class IStateBuilder {
  IState initState();
  IState buildState();
}