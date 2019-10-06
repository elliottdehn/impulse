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
        baseReactionWindow: Function.apply(baseReactionWindowF, []),
        isStopped: Function.apply(isStoppedF, []),
        isReset: Function.apply(isResetF, []));
  }

  /*
  Strategies
   */

  //Reaction windows
  ReactionWindow getReactionWindowConstant() {
    return ReactionWindow() << 700;
  }

  //Base reaction windows
  BaseReactionWindow getBaseReactionWindow() {
    return BaseReactionWindow() << _gameModel.baseReactionWindow;
  }

  //Is stopped
  IsStopped getIsStopped() {
    return IsStopped() << true;
  }

  //Is reset
  IsReset getIsReset() {
    return IsReset() << true;
  }
}

class Reaction {
  final ReactionWindow reactionWindow;
  final BaseReactionWindow baseReactionWindow;
  final IsStopped isStopped;
  final IsReset isReset;

  const Reaction(
      {this.reactionWindow,
      this.baseReactionWindow,
      this.isStopped,
      this.isReset});
}

class ReactionWindow extends Value<int> {}

class BaseReactionWindow extends Value<int> {}

class IsStopped extends Value<bool> {}

class IsReset extends Value<bool> {}
