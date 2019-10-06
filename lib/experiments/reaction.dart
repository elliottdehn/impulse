import 'package:impulse/experiments/game.dart';

import 'value.dart';

class ReactionModel {
//this is maybe a little more confusing than it needs to be
//consider refactoring the (class XModel) pattern to (extends Model<X>)

  final GameModel _gameModel;
  ReactionModel(this._gameModel);

  //Game model will dynamically pick the right algorithms
  Reaction get reaction {
    return new Reaction(
        reactionWindow: _gameModel.reactionWindow,
        baseReactionWindow: _gameModel.baseReactionWindow,
        isStopped: _gameModel.isStopped,
        isReset: _gameModel.isReset);
  }

  //Reaction windows
  ReactionWindow getReactionWindowConstant() {
    return ReactionWindow() << 700;
  }

  //Base reaction windows
  BaseReactionWindow getBaseReactionWindow() {
    return BaseReactionWindow() << 700;
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

  Reaction(
      {this.reactionWindow,
      this.baseReactionWindow,
      this.isStopped,
      this.isReset});
}

class ReactionWindow extends Value<int> {}

class BaseReactionWindow extends Value<int> {}

class IsStopped extends Value<bool> {}

class IsReset extends Value<bool> {}
