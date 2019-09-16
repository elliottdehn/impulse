import 'dart:math';

import 'package:impulse/generator/IGeneratorSuccess.dart';
import 'package:impulse/state/AppStateManager.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/state/IAppStateManager.dart';

class GeneratorSuccessOdds implements IGeneratorSuccess {

  double _oddsOfFailureSymbol;

  GeneratorSuccessOdds(IAppStateManager manager){
    _oddsOfFailureSymbol =
        manager.getConfigValue(AppConfigKey.FAILURE_SYMBOL_ODDS);
  }

  @override
  bool generateIsFailureSymbol() {
    var random = Random.secure();
    return random.nextDouble() <= _oddsOfFailureSymbol;
  }

}