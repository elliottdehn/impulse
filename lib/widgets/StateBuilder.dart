import 'package:impulse/state/AppStateManager.dart';
import 'package:impulse/state/IAppStateManager.dart';
import 'package:impulse/widgets/IStateBuilder.dart';

abstract class StateBuilder implements IStateBuilder {
  final IAppStateManager manager = AppStateManager();
}