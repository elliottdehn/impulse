import 'dart:math';

import 'package:impulse/state/AppStateStore.dart';

import '../../Oracle.dart';

class OracleKillerSymbolOdds extends Oracle {
  @override
  getAnswer() {
    var random = Random.secure();
    return
        manager.getConfigValue(AppConfigKey.FAILURE_SYMBOL_ODDS);
  }
}
