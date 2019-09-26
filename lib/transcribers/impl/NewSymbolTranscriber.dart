import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/symbol/OracleSymbolsRandom.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/transcribers/Transcriber.dart';

class NewSymbolTranscriber extends Transcriber {

  final IOracle nextSymbol = OracleSymbolsRandom();

  @override
  writeToState() {
    manager.updateState(AppStateKey.SYMBOL, nextSymbol.getAnswer());
    manager.updateState(AppStateKey.SYMBOL_TAPPED_COUNT, 0);
  }

}