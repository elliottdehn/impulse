import 'package:impulse/state/AppStateStore.dart';

class IAppStateListener{
  void onModelChanged(AppStateKey key, var value){}
  bool shouldNotifyForKeyStateChange(AppStateKey key){return false;}
}