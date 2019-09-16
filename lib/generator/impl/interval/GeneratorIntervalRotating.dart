import 'package:impulse/generator/IGeneratorInterval.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/state/IAppStateManager.dart';

class GeneratorIntervalRotating implements IGeneratorInterval{

  IAppStateManager manager;
  int index = 0;
  List<int> intervals = [];

  GeneratorIntervalRotating(this.manager){
    intervals.add(manager.getConfigValue(AppConfigKey.INTERVAL_SYMBOL_FAST));
    intervals.add(manager.getConfigValue(AppConfigKey.INTERVAL_SYMBOL_MEDIUM));
    intervals.add(manager.getConfigValue(AppConfigKey.INTERVAL_SYMBOL_SLOw));
  }

  @override
  int generateInterval() {
    int interval = intervals[index % 3];
    index++;
    return interval;
  }

  int getInterval(){
    return intervals[index];
  }

}