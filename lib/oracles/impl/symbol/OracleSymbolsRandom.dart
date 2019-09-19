import 'dart:math';

import 'package:impulse/oracles/impl/success/OracleKillerSymbolOdds.dart';
import 'package:impulse/state/AppStateStore.dart';

import '../../Oracle.dart';

class OracleSymbolsRandom extends Oracle {

  List<String> _successLetters;
  List<String> _failureLetters;

  OracleSymbolsRandom(){
    _successLetters = manager.getConfigValue(AppConfigKey.SUCCESS_LETTERS);
    _failureLetters = manager.getConfigValue(AppConfigKey.FAILURE_LETTERS);
  }

  @override
  getAnswer() {
    var random = Random.secure();
    Oracle killerOracle = OracleKillerSymbolOdds();
    if(killerOracle.getAnswer()){
      return _failureLetters[random.nextInt(_failureLetters.length)];
    } else {
      return _successLetters[random.nextInt(_successLetters.length)];
    }
  }
}