import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/state/IAppStateUpdateHandler.dart';
import 'package:impulse/widgets/IPresenter.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateBuilder.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';
import 'package:impulse/widgets/game/lives/LivesStateBuilder.dart';

class LivesWidgetPresenter implements IPresenter, IAppStateUpdateHandler {

  final IStateBuilder stateBuilder = LivesStateBuilder();
  final List<AppStateKey> keyListeners = [AppStateKey.LIVES];
  final IStateUpdateListener stateUpdateListener;

  LivesWidgetPresenter(this.stateUpdateListener);

  @override
  IState initState() {
    return stateBuilder.initState();
  }

  @override
  void onModelChanged(AppStateKey key, value) {
    if(AppStateKey.LIVES == key){
      IState newState = stateBuilder.buildState();
      stateUpdateListener.onStateUpdate(newState);
    }
  }

  @override
  bool shouldNotifyForKeyStateChange(AppStateKey key) {
    return keyListeners.contains(key);
  }

}