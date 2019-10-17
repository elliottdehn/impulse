import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/widgets/i_state_update_handler.dart';

class INotifier {
  addStateListener(IStateUpdateHandler presenter) {}
  removeStateListener(IStateUpdateHandler presenter) {}
  notifyListeners(StateValues s) {}
}
