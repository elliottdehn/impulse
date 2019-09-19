import 'package:impulse/state/AppStateStore.dart';

import '../../Oracle.dart';

class OracleReactionWindowConstant extends Oracle {

  @override
  getAnswer() {
    manager.getStateValue(AppStateKey.REACTION_WINDOW);
  }

}