import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/widgets/IStateUpdateHandler.dart';

class IAppStateManager {
  updateState(AppStateKey key, var value) {}
  Object getStateValue(AppStateKey key) {
    return false;
  }

  Object getConfigValue(AppConfigKey key) {
    return false;
  }

  addStateListener(IStateUpdateHandler presenter) {}
  notifyListeners(AppStateKey key, value) {}
}
