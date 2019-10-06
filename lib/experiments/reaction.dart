import 'package:impulse/experiments/game.dart';
import 'package:impulse/experiments/model_builder.dart';

import 'value.dart';

class ReactionModel implements IModelBuilder<Reaction> {
  ReactionWindow Function() reactionWindowF;
  BaseReactionWindow Function() baseReactionWindowF;
  IsStopped Function() isStoppedF;
  IsReset Function() isResetF;

  final GameModel _gameModel;
  ReactionModel(this._gameModel);

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
    return ReactionWindow() << _gameModel.baseReactionWindow;
  }

  ReactionWindow getReactionWindowSpeedsUp() {
    int baseWindow = _gameModel.baseReactionWindow;
    double scaledWindow = baseWindow * _gameModel.reactionWindowScalar;
    int finalWindow =
        scaledWindow.round() + _gameModel.reactionWindowAdjustment;
    return ReactionWindow() << finalWindow;
  }

  //Base reaction windows
  BaseReactionWindow getBaseReactionWindow() {
    return BaseReactionWindow() << _gameModel.baseReactionWindow;
  }
}

class Reaction {
  final ReactionWindow reactionWindow;
  final BaseReactionWindow baseReactionWindow;

  const Reaction({this.reactionWindow, this.baseReactionWindow});
}

class ReactionWindow extends Value<int> {}

class BaseReactionWindow extends Value<int> {}

class IsStopped extends Value<bool> {}

class IsReset extends Value<bool> {}
