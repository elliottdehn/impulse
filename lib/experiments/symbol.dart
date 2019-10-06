import 'package:impulse/experiments/model_builder.dart';

import 'game.dart';
import 'value.dart';

class SymbolModel implements IModelBuilder<Symbol> {
  final GameModel _gameModel;
  SymbolModel(this._gameModel);

  @override
  Symbol build() {
    //this allows for dynamically calling different algorithms
    Symbol symbol = new Symbol(
        visibilityTime: getVisibilityTimeConstant(),
        intervalTime: getIntervalConstant(),
        shownSymbol: getShownBasic());
    return symbol;
  }

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

  Symbol({this.visibilityTime, this.intervalTime, this.shownSymbol});
}

class VisibilityTime extends Value<int> {}

class IntervalTime extends Value<int> {}

class ShownSymbol extends Value<String> {}
