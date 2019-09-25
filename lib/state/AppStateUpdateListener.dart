import 'package:impulse/state/AppStateManager.dart';
import 'package:impulse/state/IAppStateManager.dart';
import 'package:impulse/state/IAppStateUpdateHandler.dart';

class AppStateUpdateListener {
  static final IAppStateManager _manager = AppStateManager();
  listen(IAppStateUpdateHandler handler){
    _manager.addStateListener(handler);
  }
}