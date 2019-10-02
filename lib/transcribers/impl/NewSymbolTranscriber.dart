import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/symbol/OracleSymbolsRandom.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/transcribers/ITranscriber.dart';
import 'package:impulse/transcribers/Transcriber.dart';
import 'package:impulse/transcribers/impl/RewardPlayerTranscriber.dart';

class NewSymbolTranscriber extends Transcriber {
  final IOracle nextSymbolGenerator = OracleSymbolsRandom();
  final ITranscriber rewardPlayer = RewardPlayerTranscriber();

  @override
  writeToState() {
    String symbol = manager.getStateValue(AppStateKey.SYMBOL);
    List<String> successSymbols = manager.getConfigValue(AppConfigKey.SUCCESS_LETTERS);
    int tapCount = manager.getStateValue(AppStateKey.SYMBOL_TAPPED_COUNT);
    if(!successSymbols.contains(symbol) && tapCount == 0){
      rewardPlayer.writeToState();
    }

    String nextSymbol = nextSymbolGenerator.getAnswer();
    manager.updateState(AppStateKey.SYMBOL, nextSymbol);
    manager.updateState(AppStateKey.SYMBOL_TAPPED_COUNT, 0);
    manager.updateState(AppStateKey.REACTION_WINDOW_CLOSED, false);
  }
}
