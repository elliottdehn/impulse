import 'package:impulse/experiments/game.dart';
import 'package:impulse/experiments/model_builder.dart';

import 'value.dart';

class ReactionModel implements IModelBuilder<Reaction> {
//this is maybe a little more confusing than it needs to be
//consider refactoring the (class XModel) pattern to (extends Model<X>)

  final GameModel _gameModel;
  ReactionModel(this._gameModel);

  //Game model will dynamically pick the right algorithms

  @override
  Reaction build() {
    return new Reaction(
        reactionWindow: getReactionWindowConstant(),
        baseReactionWindow: getBaseReactionWindow(),
        isStopped: getIsStopped(),
        isReset: getIsReset());
  }

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