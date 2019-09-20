import 'package:impulse/state/AppStateStore.dart';

import '../../Oracle.dart';

class OracleReactionWindowConstant extends Oracle {

  @override
  getAnswer() {
    return manager.getStateValue(AppStateKey.REACTION_WINDOW);
  }

}