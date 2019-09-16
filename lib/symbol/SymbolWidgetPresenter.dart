import 'dart:async';

import 'package:impulse/IAppStateListener.dart';
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
import 'package:impulse/strategy/IDeathEvaluator.dart';
import 'package:impulse/strategy/impl/survival/DeathEvaluatorNoLives.dart';
import 'package:impulse/symbol/ISymbolEventListener.dart';

class SymbolWidgetPresenter implements IAppStateListener {

  //view(ish)
  ISymbolEventListener symbolWidgetState;
  //model
  IAppStateManager stateManager = new AppStateManager();
  //generators
  IGeneratorSymbol symbolGenerator;
  IGeneratorSuccess successGenerator;
  IGeneratorInterval intervalGenerator;
  IGeneratorSymbolVisibilityTime visibilityTimeGenerator;
  //strategies
  IDeathEvaluator deathChecker;
  //config
  final List<AppStateKey> keyListeners = [AppStateKey.SYMBOL, AppStateKey.PLAYER_IS_ALIVE];
  //timers
  Timer newSymbolTimer;
  Timer symbolVisibilityTimer;

  SymbolWidgetPresenter(this.symbolWidgetState){
    stateManager.addStateListener(this);

    symbolGenerator = new GeneratorLettersRandom(stateManager);
    successGenerator = new GeneratorSuccessOdds(stateManager);
    intervalGenerator = new GeneratorIntervalRotating(stateManager);
    visibilityTimeGenerator = new GeneratorSymbolVisibilityTimeConfig(stateManager);

    deathChecker = new DeathEvaluatorNoLives(stateManager);

    newSymbolTimer = _createNewSymbolTimer();
    symbolVisibilityTimer = _createNewSymbolVisibilityTimer();
  }

  _createNewSymbolVisibilityTimer(){
    return new Timer(_createNewSymbolVisibilityTime(), () => _hideSymbol());
  }

  _createNewSymbolVisibilityTime(){
    return Duration(milliseconds: visibilityTimeGenerator.generateVisibilityTime());
  }
  _createNewSymbolTimer(){
    return new Timer(_createNewSymbolInterval(), () => _updateSymbolEvent());
  }
  _createNewSymbolInterval(){
    return Duration(milliseconds: intervalGenerator.generateInterval());
  }

  playerReacted(){
    stateManager.updateState(
        AppStateKey.PLAYER_IS_ALIVE,
        deathChecker.willPlayerSurvive());
  }

  _updateSymbolEvent(){
    stateManager.updateState(
        AppStateKey.SYMBOL,
        symbolGenerator.generate(successGenerator.generateIsFailureSymbol())
    );
  }

  _updateSymbol(String s){
    symbolWidgetState.setSymbol(s);
  }

  _hideSymbol(){
    symbolWidgetState.setSymbolVisibility(0.0);
  }

  _showSymbol(){
    symbolWidgetState.setSymbolVisibility(1.0);
  }

  _killUser(){
    symbolWidgetState.killUser();
  }

  @override
  void onModelChanged(AppStateKey key, value) {
    if(key == AppStateKey.SYMBOL){
      _updateSymbol(value as String);
      _showSymbol();
      newSymbolTimer = _createNewSymbolTimer();
      symbolVisibilityTimer = _createNewSymbolVisibilityTimer();
    } else if(key == AppStateKey.PLAYER_IS_ALIVE && value as bool == false){
      _killUser();
    }
  }

  @override
  bool shouldNotifyForKeyStateChange(AppStateKey key) {
    return keyListeners.contains(key);
  }
}
