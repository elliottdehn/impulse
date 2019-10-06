import 'game.dart';
import 'value.dart';

class SymbolModel {
  final GameModel _gameModel;
  SymbolModel(this._gameModel);

  //Game model will dynamically pick the right algorithms
  Symbol getSymbol() {
    Symbol symbol = new Symbol(
        visibilityTime: _gameModel.visibilityTime,
        intervalTime: _gameModel.intervalTime,
        shownSymbol: _gameModel.shownSymbol);
    return symbol;
  }

  //Get symbol
  ShownSymbol getShownBasic() {
    return ShownSymbol() << _gameModel.shown;
  }

  //Get interval
  IntervalTime getIntervalRotating() {
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
