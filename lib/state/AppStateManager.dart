import 'package:impulse/state/IAppStateUpdateHandler.dart';
import 'package:impulse/state/IAppStateManager.dart';
import 'package:impulse/state/AppStateStore.dart';

class AppStateManager implements IAppStateManager {

  static final AppStateManager _singleton = new AppStateManager._privateConstructor();
  static final _state = new AppStateStore();

  factory AppStateManager(){
    return _singleton;
  }

  AppStateManager._privateConstructor();

  List<IAppStateUpdateHandler> presenters = [];

  @override
  Object getStateValue(AppStateKey key) {
    return _state.getStateValueForKey(key);
  }

  //TODO see if you can't abstract this for callers
  @override
  Object getConfigValue(AppConfigKey key) {
    return _state.getConfigValueForKey(key);
  }

  @override
  updateState(AppStateKey key, value) {
    _state.setStateValueForKey(key, value);
    notifyListeners(key, value);
  }

  @override
  notifyListeners(AppStateKey key, value){
    for(IAppStateUpdateHandler presenter in presenters){
      if(presenter.shouldNotifyForKeyStateChange(key)){
        presenter.onModelChanged(key, value);
      }
    }
  }

  @override
  addStateListener(IAppStateUpdateHandler presenter) {
    presenters.add(presenter);
  }

}