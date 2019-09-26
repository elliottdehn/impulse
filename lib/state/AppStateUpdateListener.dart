import 'package:impulse/state/AppStateManager.dart';
import 'package:impulse/state/IAppStateManager.dart';
import 'package:impulse/widgets/IStateUpdateHandler.dart';

class AppStateUpdateListener {
  static final IAppStateManager _manager = AppStateManager();
  listen(IStateUpdateHandler handler){
    _manager.addStateListener(handler);
  }
}