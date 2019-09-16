import 'package:impulse/IAppStateListener.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/state/IAppStateManager.dart';
import 'package:impulse/strategy/IDeathEvaluator.dart';

class DeathEvaluatorNoLives implements IDeathEvaluator, IAppStateListener {

  List<String> _failSymbols;
  IAppStateManager manager;
  bool _symbolIsDeadly;

  DeathEvaluatorNoLives(this.manager){
    manager.addStateListener(this);
    _failSymbols = manager.getConfigValue(AppConfigKey.FAILURE_LETTERS) as List<String>;
  }

  @override
  bool willPlayerSurvive(){
    return !_symbolIsDeadly;
  }

  @override
  void onModelChanged(AppStateKey key, value) {
    if(key == AppStateKey.SYMBOL){
      _symbolIsDeadly = _failSymbols.contains(value);
    }
  }

  @override
  bool shouldNotifyForKeyStateChange(AppStateKey key) {
    return key == AppStateKey.SYMBOL;
  }
}