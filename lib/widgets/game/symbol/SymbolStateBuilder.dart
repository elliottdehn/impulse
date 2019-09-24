import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/interval/OracleIntervalRotating.dart';
import 'package:impulse/oracles/impl/reaction/OracleReactionWindowConstant.dart';
import 'package:impulse/oracles/impl/symbol/OracleSymbolsRandom.dart';
import 'package:impulse/oracles/impl/visibility/OracleSymbolVisibilityConstant.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/IStateBuilder.dart';

import 'SymbolState.dart';

class SymbolStateBuilder implements IStateBuilder {

  final IOracle visibilityDuration = OracleSymbolVisibilityConstant();
  final IOracle nextSymbolInterval = OracleIntervalRotating();
  final IOracle reactionWindow = OracleReactionWindowConstant();
  final IOracle nextSymbol = OracleSymbolsRandom();

  @override
  IState buildState() {
    SymbolState state = SymbolState();
    state.symbol = nextSymbol.getAnswer();
    state.visibilityDuration = visibilityDuration.getAnswer();
    state.nextSymbolInterval = nextSymbolInterval.getAnswer();
    return state;
  }

  @override
  IState initState() {
    SymbolState state = SymbolState();
    state.symbol = "";
    state.visibilityDuration = visibilityDuration.getAnswer();
    state.nextSymbolInterval = nextSymbolInterval.getAnswer();
    return state;
  }

}