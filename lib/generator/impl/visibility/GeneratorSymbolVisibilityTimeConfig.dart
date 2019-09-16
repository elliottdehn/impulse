import 'package:impulse/generator/IGeneratorSymbolVisibilityTime.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/state/IAppStateManager.dart';

class GeneratorSymbolVisibilityTimeConfig implements IGeneratorSymbolVisibilityTime {

  int _configValue;

  GeneratorSymbolVisibilityTimeConfig(IAppStateManager manager){
    _configValue =
        manager.getConfigValue(AppConfigKey.SYMBOL_VISIBILITY_DURATION);
  }
  @override
  int generateVisibilityTime() {
    return _configValue;
  }

}