import 'package:impulse/experiments/refactor/model.dart';
import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/experiments/values.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:test/test.dart';

void main(){
  test('Instantiated model', () {
    Model();
  });

  test('Initializing model', () {
    Model m = Model();
    m.onEvent(Event(EventID.START_DIFFICULTY_HERO));
  });

  test('Init and trigger new symbol', () {
    Model m = Model();
    StateValues sv = m.onEvent(Event(EventID.START_DIFFICULTY_HERO));
    sv = m.onEvent(Event(EventID.NEW_SYMBOL));
    assert(sv != null);
  });
}