import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/window/OracleReactionWindowConstant.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/StateBuilder.dart';

import 'ReactionWindowState.dart';

class ReactionWindowStateBuilder extends StateBuilder {

  final IOracle reactionWindowDuration = OracleReactionWindowConstant();

  @override
  IState buildState() {
    ReactionWindowState state = ReactionWindowState();
    state.baseReactionWindow = manager.getConfigValue(AppConfigKey.BASE_REACTION_WINDOW);
    state.currReactionWindow = reactionWindowDuration.getAnswer();

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