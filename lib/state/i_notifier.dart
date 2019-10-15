import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/widgets/IStateUpdateHandler.dart';

class INotifier {
  addStateListener(IStateUpdateHandler presenter) {}
  removeStateListener(IStateUpdateHandler presenter) {}
  notifyListeners(StateValues s) {}
}
