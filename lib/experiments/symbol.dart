import 'dart:math';

import 'package:impulse/experiments/model_builder.dart';
import 'package:impulse/widgets/EventID.dart';

import 'game.dart';
import 'value.dart';

class SymbolModel implements IModelBuilder<Symbol> {
  Shown Function() getShownF;
  IntervalTime Function() getIntervalTimeF;
  VisibilityTime Function() getVisibilityTimeF;

  void Function() setShownF;
  void Function() setIntervalTimeF;
  void Function() setVisibilityTimeF;

  final GameModel _gameModel;

  SymbolModel(this._gameModel);

  @override
  Symbol build() {
    Symbol symbol = new Symbol(
        visibilityTime: Function.apply(getVisibilityTimeF, []),
        intervalTime: Function.apply(getIntervalTimeF, []),
        shownSymbol: Function.apply(getShownF, []));
    return symbol;
  }

  /*
  GET Strategies
   */

  //Get symbol
  Shown getShown() {
    return Shown(~_gameModel.shown);
  }

  void setShown(EventID e) {}

  //Get interval
  IntervalTime getIntervalConstant() {
    int slowestIdx = 0;
    return IntervalTime(_gameModel.intervals[slowestIdx]);
  }

  IntervalTime getIntervalSpeedsUp() {
    double interval = _gameModel.intervals[_gameModel.intervalIdx] *
        _gameModel.intervalScalar;
    interval += _gameModel.intervalAdjustment;
    return IntervalTime(max(interval.round(), _gameModel.minimumInterval));
  }

  //Get visibility time
  VisibilityTime getVisibilityTimeConstant() {
    return VisibilityTime(_gameModel.visibilityTime);
  }
}

class Symbol {
  final VisibilityTime visibilityTime;
  final IntervalTime intervalTime;
  final Shown shownSymbol;

  const Symbol({this.visibilityTime, this.intervalTime, this.shownSymbol});
}

class VisibilityTime extends Value<int> {
  VisibilityTime(int value) : super(value);
}

class IntervalTime extends Value<int> {
  IntervalTime(int value) : super(value);
}

class Shown extends Value<String> {
  Shown(String value) : super(value);
}
