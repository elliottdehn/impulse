import 'package:impulse/IPresenter.dart';
import 'package:impulse/state/IAppStateManager.dart';
import 'package:impulse/state/AppStateStore.dart';

class AppStateManager implements IAppStateManager {

  var state = new AppStateStore();
  List<IPresenter> presenters = [];

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
    for(IPresenter presenter in presenters){
      if(presenter.shouldNotifyForKeyStateChange(key)){
        presenter.onModelChanged(key, value);
      }
    }
  }

  @override
  addStateListener(IPresenter presenter) {
    presenters.add(presenter);
  }

}