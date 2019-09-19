import 'package:impulse/state/AppStateStore.dart';

import '../../Oracle.dart';


class OracleIntervalRotating extends Oracle {

  int index = 0;
  List<int> intervals = [];

  OracleIntervalRotating(){
    intervals.add(manager.getConfigValue(AppConfigKey.INTERVAL_SYMBOL_FAST));
    intervals.add(manager.getConfigValue(AppConfigKey.INTERVAL_SYMBOL_MEDIUM));
    intervals.add(manager.getConfigValue(AppConfigKey.INTERVAL_SYMBOL_SLOw));
  }

  @override
  getAnswer() {
    int interval = intervals[index % 3];
    index++;
    return interval;
  }

}