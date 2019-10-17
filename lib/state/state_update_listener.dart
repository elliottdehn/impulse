import 'package:impulse/state/notifier.dart';
import 'package:impulse/state/i_notifier.dart';
import 'package:impulse/widgets/i_state_update_handler.dart';

class StateUpdateListener {
  static final INotifier _notifier = Notifier();
  listen(IStateUpdateHandler handler) {
    _notifier.addStateListener(handler);
  }

  unsubscribe(IStateUpdateHandler handler) {
    _notifier.removeStateListener(handler);
  }
}
