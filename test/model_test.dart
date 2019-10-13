import 'package:impulse/experiments/refactor/constants.dart';
import 'package:impulse/experiments/refactor/id/value_id.dart';
import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/experiments/values.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:test/test.dart';

void main(){
  test('Instantiated model', () {
    Model();
  });

  test('Sanity: initializing model', () {
    Model m = Model();
    m.onEvent(Event(EventID.START_DIFFICULTY_HERO));
  });

  test('Sanity: init and trigger new symbol', () {
    Model m = Model();
    StateValues sv = m.onEvent(Event(EventID.START_DIFFICULTY_HERO));
    sv = m.onEvent(Event(EventID.NEW_SYMBOL));
    assert(sv != null);
  });

  //I realize non-deterministic tests are pants-on-head
  test('Init, new symbol, tap', () {
    Model m = Model();
    StateValues sv = m.onEvent(Event(EventID.START_DIFFICULTY_HERO));
    sv = m.onEvent(Event(EventID.NEW_SYMBOL));
    sv = m.onEvent(Event(EventID.PLAYER_REACTED));
    //TODO : real asserts, see why this is doing nothing
    assert(~sv.get(ValueID.SHOWN_SYMBOL) != "");
    assert(~sv.get(ValueID.TAP_COUNT) == 1);
    if(Constants.normalSymbols.contains(~sv.get(ValueID.SHOWN_SYMBOL))){
      assert(~sv.get(ValueID.NORMAL_SYMBOL_TOTAL) == 1);
      assert(~sv.get(ValueID.KILLER_SYMBOL_TOTAL) == 0);
      assert(~sv.get(ValueID.SCORE) != 0);
      assert(~sv.get(ValueID.LIVES) == Constants.livesStartHero);
    } else {
      assert(~sv.get(ValueID.NORMAL_SYMBOL_TOTAL) == 0);
      assert(~sv.get(ValueID.KILLER_SYMBOL_TOTAL) == 0);
      assert(~sv.get(ValueID.SCORE) == 0);
      assert(~sv.get(ValueID.LIVES) == Constants.livesStartHero - 1);
    }
    assert(sv != null);
  });

  test('Init, new symbol, tap, close, tap', () {
    Model m = Model();
    StateValues sv = m.onEvent(Event(EventID.START_DIFFICULTY_HERO));
    sv = m.onEvent(Event(EventID.NEW_SYMBOL));
    sv = m.onEvent(Event(EventID.PLAYER_REACTED));
    sv = m.onEvent(Event(EventID.ENFORCE_TAP));
    sv = m.onEvent(Event(EventID.PLAYER_REACTED));
    //TODO : real asserts, see why this is doing nothing
    assert(~sv.get(ValueID.SHOWN_SYMBOL) != "");
    assert(~sv.get(ValueID.TAP_COUNT) == 2);
    if(Constants.normalSymbols.contains(~sv.get(ValueID.SHOWN_SYMBOL))){
      assert(~sv.get(ValueID.NORMAL_SYMBOL_TOTAL) == 1);
      assert(~sv.get(ValueID.KILLER_SYMBOL_TOTAL) == 0);
      assert(~sv.get(ValueID.SCORE) != 0);
      assert(~sv.get(ValueID.LIVES) == Constants.livesStartHero);
    } else {
      assert(~sv.get(ValueID.NORMAL_SYMBOL_TOTAL) == 0);
      assert(~sv.get(ValueID.KILLER_SYMBOL_TOTAL) == 0);
      assert(~sv.get(ValueID.LIVES) == Constants.livesStartHero - 2);
      assert(~sv.get(ValueID.SCORE) == 0);
    }
    assert(sv != null);
  });
}