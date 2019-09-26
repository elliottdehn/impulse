import 'package:impulse/state/AppStateStore.dart';

class IStateUpdateHandler{
  void onModelChanged(AppStateKey key, var value){}
  bool shouldNotifyForKeyStateChange(AppStateKey key){return false;}
}