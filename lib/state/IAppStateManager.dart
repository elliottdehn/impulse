import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/IPresenter.dart';

class IAppStateManager{
  updateState(AppStateKey key, var value){}
  Object getStateValue(AppStateKey key){ return false; }
  Object getConfigValue(AppConfigKey key) { return false; }
  addStateListener(IPresenter presenter){}
  notifyListeners(AppStateKey key, value){}
}