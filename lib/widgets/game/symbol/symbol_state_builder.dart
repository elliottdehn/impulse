import 'package:impulse/experiments/refactor/constants.dart';
import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/widgets/i_state_builder.dart';
import 'package:impulse/widgets/i_view_state.dart';

import 'symbol_state.dart';

class SymbolStateBuilder implements IStateBuilder {
  @override
  IViewState buildState(StateValues s) {
    SymbolState state = SymbolState();
    state.symbol = ~s.get(ValueID.SHOWN_SYMBOL);
    state.visibilityDuration = Constants.visibilityTime;
    state.nextSymbolInterval = ~s.get(ValueID.INTERVAL_LENGTH);
    return state;
  }

  @override
  IViewState initState(StateValues s) {
    SymbolState state = SymbolState();
    state.symbol = ~s.get(ValueID.SHOWN_SYMBOL);
    state.visibilityDuration = Constants.visibilityTime;
    state.nextSymbolInterval = ~s.get(ValueID.INTERVAL_LENGTH);
    return state;
  }
}
