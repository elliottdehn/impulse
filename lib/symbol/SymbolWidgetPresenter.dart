import 'dart:async';

import 'package:impulse/IPresenter.dart';
import 'package:impulse/generator/IGeneratorInterval.dart';
import 'package:impulse/generator/IGeneratorSuccess.dart';
import 'package:impulse/generator/IGeneratorSymbolVisibilityTime.dart';
import 'package:impulse/generator/impl/interval/GeneratorIntervalRotating.dart';
import 'package:impulse/generator/impl/success/GeneratorSuccessOdds.dart';
import 'package:impulse/generator/impl/symbol/GeneratorLettersRandom.dart';
import 'package:impulse/generator/impl/visibility/GeneratorSymbolVisibilityTimeConfig.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/generator/IGeneratorSymbol.dart';
import 'package:impulse/state/AppStateManager.dart';
import 'package:impulse/state/IAppStateManager.dart';
import 'package:impulse/symbol/ISymbolEventListener.dart';

class SymbolWidgetPresenter implements IPresenter {

  //view(ish)
  ISymbolEventListener symbolWidgetState;
  //model
  IAppStateManager stateManager = new AppStateManager();
  //helpers
  IGeneratorSymbol symbolGenerator;
  IGeneratorSuccess successGenerator;
  IGeneratorInterval intervalGenerator;
  IGeneratorSymbolVisibilityTime visibilityTimeGenerator;
  //config
  final List<AppStateKey> keyListeners = [AppStateKey.SYMBOL];
  //timers
  Timer newSymbolTimer;
  Timer symbolVisibilityTimer;

  SymbolWidgetPresenter(this.symbolWidgetState){
    stateManager.addStateListener(this);

    symbolGenerator = new GeneratorLettersRandom(stateManager);
    successGenerator = new GeneratorSuccessOdds(stateManager);
    intervalGenerator = new GeneratorIntervalRotating(stateManager);
    visibilityTimeGenerator = new GeneratorSymbolVisibilityTimeConfig(stateManager);

    newSymbolTimer = _createNewSymbolTimer();
    symbolVisibilityTimer = _createNewSymbolVisibilityTimer();
  }

  _createNewSymbolVisibilityTimer(){
    return new Timer(_createNewSymbolVisibilityTime(), () => killSymbol());
  }

  _createNewSymbolVisibilityTime(){
    return Duration(milliseconds: visibilityTimeGenerator.generateVisibilityTime());
  }
  _createNewSymbolTimer(){
    return new Timer(_createNewSymbolInterval(), () => updateSymbol());
  }
  _createNewSymbolInterval(){
    return Duration(milliseconds: intervalGenerator.generateInterval());
  }

  playerReacted(){
    //TODO This should simply kill or not kill the player
  }

  updateSymbol(){
    stateManager.updateState(
        AppStateKey.SYMBOL,
        symbolGenerator.generate(successGenerator.generateIsFailureSymbol())
    );
  }

  killSymbol(){
    symbolWidgetState.setSymbolVisibility(0.0);
  }

  @override
  void onModelChanged(AppStateKey key, value) {
    if(key == AppStateKey.SYMBOL){
      symbolWidgetState.setSymbol(value as String);
      symbolWidgetState.setSymbolVisibility(1.0);
      newSymbolTimer = _createNewSymbolTimer();
      symbolVisibilityTimer = _createNewSymbolVisibilityTimer();
    }
  }

  @override
  bool shouldNotifyForKeyStateChange(AppStateKey key) {
    return keyListeners.contains(key);
  }
}
