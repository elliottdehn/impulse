import 'package:impulse/state/AppStateStore.dart';

import '../../Oracle.dart';

class OracleReactionWindowConstant extends Oracle {
  @override
  getAnswer() {
    return manager.getConfigValue(AppConfigKey.BASE_REACTION_WINDOW);
  }
}
