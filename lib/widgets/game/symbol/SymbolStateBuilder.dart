import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/interval/OracleIntervalRotating.dart';
import 'package:impulse/oracles/impl/symbol/OracleSymbolsRandom.dart';
import 'package:impulse/oracles/impl/visibility/OracleSymbolVisibilityConstant.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/widgets/IState.dart';

import '../../StateBuilder.dart';
import 'SymbolState.dart';

class SymbolStateBuilder extends StateBuilder {
  final IOracle visibilityDuration = OracleSymbolVisibilityConstant();
  final IOracle nextSymbolInterval = OracleIntervalRotating();
  final IOracle nextSymbol = OracleSymbolsRandom();

  @override
  IState buildState() {
    SymbolState state = SymbolState();
    state.symbol = manager.getStateValue(AppStateKey.SYMBOL);
    state.visibilityDuration = visibilityDuration.getAnswer();
    state.nextSymbolInterval = nextSymbolInterval.getAnswer();
    return state;
  }

  @override
  IState initState() {
    SymbolState state = SymbolState();
    state.symbol = "X";
    state.visibilityDuration = visibilityDuration.getAnswer();
    state.nextSymbolInterval = nextSymbolInterval.getAnswer();
    return state;
  }
}
