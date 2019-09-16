import 'dart:math';

import 'package:impulse/generator/IGeneratorSymbol.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/state/IAppStateManager.dart';

class GeneratorLettersRandom implements IGeneratorSymbol {

  final IAppStateManager manager;

  List<String> _successLetters;
  List<String> _failureLetters;

  GeneratorLettersRandom(this.manager){
    _initLetterSymbols();
  }

  void _initLetterSymbols(){
    _successLetters = manager.getConfigValue(AppConfigKey.SUCCESS_LETTERS)
    as List<String>;
    _failureLetters = manager.getConfigValue(AppConfigKey.FAILURE_LETTERS)
    as List<String>;
  }

  @override
  String generate(bool isFailureSymbol) {
    var random = Random.secure();
    if(isFailureSymbol){
      return _failureLetters[random.nextInt(_failureLetters.length)];
    } else {
      return _successLetters[random.nextInt(_successLetters.length)];
    }
  }
}