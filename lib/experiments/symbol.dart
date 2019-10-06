import 'package:impulse/experiments/model_builder.dart';

import 'game.dart';
import 'value.dart';

class SymbolModel implements IModelBuilder<Symbol> {
  ShownSymbol Function() shownF;
  IntervalTime Function() intervalTimeF;
  VisibilityTime Function() visibilityTimeF;

  final GameModel _gameModel;

  SymbolModel(this._gameModel);

  @override
  Symbol build() {
    //this allows for dynamically calling different algorithms
    Symbol symbol = new Symbol(
        visibilityTime: Function.apply(visibilityTimeF, []),
        intervalTime: Function.apply(intervalTimeF, []),
        shownSymbol: Function.apply(visibilityTimeF, []));
    return symbol;
  }

  /*
  Strategies
   */

  //Get symbol
  ShownSymbol getShownBasic() {
    return ShownSymbol() << _gameModel.shown;
  }

  //Get interval
  IntervalTime getIntervalConstant() {
    return IntervalTime() << 3000;
  }

  //Get visibility time
  VisibilityTime getVisibilityTimeConstant() {
    return VisibilityTime() << 125;
  }
}

class Symbol {
  final VisibilityTime visibilityTime;
  final IntervalTime intervalTime;
  final ShownSymbol shownSymbol;

  const Symbol({this.visibilityTime, this.intervalTime, this.shownSymbol});
}

class VisibilityTime extends Value<int> {}

class IntervalTime extends Value<int> {}

class ShownSymbol extends Value<String> {}
