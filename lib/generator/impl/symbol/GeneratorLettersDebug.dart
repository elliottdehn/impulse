import 'package:impulse/generator/IGeneratorSymbol.dart';

class GeneratorLettersDebug implements IGeneratorSymbol {
  @override
  String generate(bool isFailureSymbol){ return "A"; }
}