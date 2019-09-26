import 'package:impulse/state/AppStateStore.dart';

import '../../Oracle.dart';

class OracleSymbolVisibilityConstant extends Oracle {
  @override
  getAnswer() {
    return manager.getConfigValue(AppConfigKey.SYMBOL_VISIBILITY_DURATION);
  }
}
