import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/state/AppStateManager.dart';
import 'package:impulse/state/IAppStateManager.dart';

abstract class Oracle extends IOracle {
  final IAppStateManager manager = AppStateManager();
}
