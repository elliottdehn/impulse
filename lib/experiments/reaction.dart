import 'package:impulse/experiments/game.dart';
import 'package:impulse/experiments/model_builder.dart';

import 'values.dart';

class ReactionModel implements IModelBuilder<Reaction> {
  ReactionWindow Function() reactionWindowF;
  BaseReactionWindow Function() baseReactionWindowF;
  IsStopped Function() isStoppedF;
  IsReset Function() isResetF;

  final GameState _gameState;
  ReactionModel(this._gameState);

  @override
  Reaction build() {
    return new Reaction(
        reactionWindow: Function.apply(reactionWindowF, []),
        baseReactionWindow: Function.apply(baseReactionWindowF, []));
  }

  /*
  Strategies
   */

  //Reaction windows
  ReactionWindow getReactionWindowConstant() {
    return ReactionWindow(_gameState.baseReactionWindow);
  }

  ReactionWindow getReactionWindowSpeedsUp() {
    int baseWindow = _gameState.baseReactionWindow;
    double scaledWindow = baseWindow * _gameState.reactionWindowScalar;
    int finalWindow =
        scaledWindow.round() + _gameState.reactionWindowAdjustment;
    return ReactionWindow(finalWindow);
  }

  //Base reaction windows
  BaseReactionWindow getBaseReactionWindow() {
    return BaseReactionWindow(_gameState.baseReactionWindow);
  }
}
