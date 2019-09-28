import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/window/OracleReactionWindowConstant.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/StateBuilder.dart';

import 'ReactionWindowState.dart';

class ReactionWindowStateBuilder extends StateBuilder {

  final IOracle reactionWindowDuration = OracleReactionWindowConstant();
  List<String> _normalSymbols;
  String _previousSymbol;

  ReactionWindowStateBuilder(){
    _normalSymbols = manager.getConfigValue(AppConfigKey.SUCCESS_LETTERS);
  }
  @override
  IState buildState() {
    ReactionWindowState state = ReactionWindowState();
    state.baseReactionWindow = manager.getConfigValue(AppConfigKey.BASE_REACTION_WINDOW);
    state.currReactionWindow = reactionWindowDuration.getAnswer();
    bool isTapped = (manager.getStateValue(AppStateKey.SYMBOL_TAPPED_COUNT) as int) > 0;
    String currentSymbol = manager.getStateValue(AppStateKey.SYMBOL);;
    bool isNormalSymbol = _normalSymbols.contains(currentSymbol);

    state.isStopped = true;
    if(!isTapped && isNormalSymbol){
      state.isStopped = false;
    }

    state.isReset = false;
    if(currentSymbol != _previousSymbol){
      state.isReset = true;
    }

    return state;
  }

  @override
  IState initState() {
    ReactionWindowState state = ReactionWindowState();
    state.baseReactionWindow = manager.getConfigValue(AppConfigKey.BASE_REACTION_WINDOW);
    state.currReactionWindow = manager.getConfigValue(AppConfigKey.BASE_REACTION_WINDOW);
    state.isStopped = false;
    state.isReset = false;
    return state;
  }

}