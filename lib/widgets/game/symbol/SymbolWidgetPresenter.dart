import 'dart:async';

import 'package:impulse/oracles/impl/reaction/OracleReactionWindowConstant.dart';
import 'package:impulse/state/IAppStateListener.dart';
import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/interval/OracleIntervalRotating.dart';
import 'package:impulse/oracles/impl/success/OracleKillerSymbolOdds.dart';
import 'package:impulse/oracles/impl/symbol/OracleSymbolsRandom.dart';
import 'package:impulse/oracles/impl/visibility/OracleSymbolVisibilityConstant.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/state/AppStateManager.dart';
import 'package:impulse/state/IAppStateManager.dart';
import 'package:impulse/oracles/impl/death/OracleDeathNoLives.dart';

import 'ISymbolEventListener.dart';

class SymbolWidgetPresenter implements IAppStateListener {

  //view(ish)
  ISymbolEventListener symbolWidgetState;
  //model
  IAppStateManager stateManager = new AppStateManager();
  //generators
  IOracle symbolGenerator = OracleSymbolsRandom();
  IOracle successGenerator = OracleKillerSymbolOdds();
  IOracle intervalGenerator = OracleIntervalRotating();
  IOracle visibilityTimeGenerator = OracleSymbolVisibilityConstant();
  IOracle deathChecker = OracleDeathNoLives();
  IOracle windowGenerator = OracleReactionWindowConstant();
  //config
  final List<AppStateKey> keyListeners = [AppStateKey.SYMBOL, AppStateKey.PLAYER_IS_ALIVE];
  //timers
  Timer newSymbolTimer;
  Timer symbolVisibilityTimer;
  Timer tapEnforcementTimer;

  SymbolWidgetPresenter(this.symbolWidgetState){
    stateManager.addStateListener(this);
    newSymbolTimer = _createNewSymbolTimer();
  }

  _createNewTapEnforcementTimer(){
    return new Timer(_createNewTapEnforcementTime(), () => _enforceTaps());
  }

  _createNewTapEnforcementTime(){
    return new Duration(milliseconds: windowGenerator.getAnswer());
  }

  _createNewSymbolVisibilityTimer(){
    return new Timer(_createNewSymbolVisibilityTime(), () => _hideSymbol());
  }

  _createNewSymbolVisibilityTime(){
    return Duration(milliseconds: visibilityTimeGenerator.getAnswer());
  }
  _createNewSymbolTimer(){
    return new Timer(_createNewSymbolInterval(), () => _updateSymbolEvent());
  }
  _createNewSymbolInterval(){
    return Duration(milliseconds: intervalGenerator.getAnswer());
  }

  playerReacted(){
    stateManager.updateState(AppStateKey.SYMBOL_TAPPED, true);
    if(deathChecker.getAnswer()) {
      stateManager.updateState(
          AppStateKey.PLAYER_IS_ALIVE,
          false);
    }
  }

  _updateSymbolEvent(){
    stateManager.updateState(
        AppStateKey.SYMBOL,
        symbolGenerator.getAnswer());
  }

  _enforceTaps(){
    if(deathChecker.getAnswer()){
      stateManager.updateState(AppStateKey.PLAYER_IS_ALIVE, false);
    }
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
    newSymbolTimer = null;
    symbolVisibilityTimer = null;
    tapEnforcementTimer = null;
    symbolWidgetState.killUser();
  }

  @override
  void onModelChanged(AppStateKey key, value) {
    if(key == AppStateKey.SYMBOL){
      _updateSymbol(value as String);
      _showSymbol();
      newSymbolTimer = _createNewSymbolTimer();
      symbolVisibilityTimer = _createNewSymbolVisibilityTimer();
      tapEnforcementTimer = _createNewTapEnforcementTimer();
      stateManager.updateState(AppStateKey.SYMBOL_TAPPED, false);
    } else if(key == AppStateKey.PLAYER_IS_ALIVE && value as bool == false){
      _killUser();
    }
  }

  @override
  bool shouldNotifyForKeyStateChange(AppStateKey key) {
    return keyListeners.contains(key);
  }
}
