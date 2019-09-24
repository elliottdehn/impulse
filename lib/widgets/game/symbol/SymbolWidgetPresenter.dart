import 'package:impulse/state/IAppStateListener.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/transcribers/ITranscriber.dart';
import 'package:impulse/transcribers/impl/NewSymbolTranscriber.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateBuilder.dart';
import 'package:impulse/widgets/IStateUpdateListener.dart';
import 'package:impulse/widgets/game/symbol/SymbolStateBuilder.dart';

import '../../IPresenter.dart';


class SymbolWidgetPresenter implements IPresenter, IAppStateListener {

  //view(ish)
  IStateUpdateListener symbolWidgetState;
  //config
  final List<AppStateKey> keyListeners = [AppStateKey.SYMBOL];
  //transcribers
  final ITranscriber newSymbol = NewSymbolTranscriber();
  //state builder
  final IStateBuilder stateBuilder = SymbolStateBuilder();

  SymbolWidgetPresenter(this.symbolWidgetState);
  //TODO: Hook up the manager listening w/ out depending on it
  //TODO: Hook up the view sending events to the presenter

  @override
  void onModelChanged(AppStateKey key, value) {
    if(key == AppStateKey.SYMBOL){
      symbolWidgetState.onStateUpdate(stateBuilder.buildState());
    }
  }

  @override
  bool shouldNotifyForKeyStateChange(AppStateKey key) {
    return keyListeners.contains(key);
  }

  @override
  IState initState() {
    return stateBuilder.initState();
  }
}
