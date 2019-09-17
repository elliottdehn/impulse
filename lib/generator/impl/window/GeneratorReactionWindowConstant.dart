import 'package:impulse/generator/IGeneratorReactionWindow.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/state/IAppStateManager.dart';

class GeneratorReactionWindowConstant implements IGeneratorReactionWindow {
  int _window;

  GeneratorReactionWindowConstant(IAppStateManager manager){
    _window = manager.getStateValue(AppStateKey.REACTION_WINDOW);
  }
  @override
  int generateReactionWindow() {
    return _window;
  }

}