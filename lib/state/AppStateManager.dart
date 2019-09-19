import 'package:impulse/state/IAppStateListener.dart';
import 'package:impulse/state/IAppStateManager.dart';
import 'package:impulse/state/AppStateStore.dart';

class AppStateManager implements IAppStateManager {

  var state = new AppStateStore();
  List<IAppStateListener> presenters = [];

  @override
  Object getStateValue(AppStateKey key) {
    return state.getStateValueForKey(key);
  }

  //TODO see if you can't abstract this for callers
  @override
  Object getConfigValue(AppConfigKey key) {
    return state.getConfigValueForKey(key);
  }

  @override
  updateState(AppStateKey key, value) {
    state.setStateValueForKey(key, value);
    notifyListeners(key, value);
  }

  @override
  notifyListeners(AppStateKey key, value){
    for(IAppStateListener presenter in presenters){
      if(presenter.shouldNotifyForKeyStateChange(key)){
        presenter.onModelChanged(key, value);
      }
    }
  }

  @override
  addStateListener(IAppStateListener presenter) {
    presenters.add(presenter);
  }

}