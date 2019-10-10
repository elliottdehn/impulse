/*
LIFE OF AN EVENT:

presenter

->e->

model(presenter, notifier)

->s,e->

interpreter

->s,e->

predicates(s).test(e)

->results->

interpreter

->results->

model

->results->

transformer

->results->

transforms.transform(results)

->s->

transformer

->s->

model

->s, e->

notifier
*/

import 'package:impulse/experiments/predicates.dart';
import 'package:impulse/experiments/state_fields.dart';
import 'package:test/test.dart';

void main() {

  /*
  Reaction window
   */

  test('RW Closes on closing', () {
    var start = ReactionWindowStatusField(true);
    var tests =
        TestResults(values: [IsWindowClosed(false), IsWindowClosing(true), IsNewSymbol(false)]);
    ReactionWindowStatusField result = start.transform(tests);
    expect(false, ~~result);
  });

  test('RW opens on new symbol after closing', () {
    var start = ReactionWindowStatusField(true);

    var closeWindow =
    TestResults(values: [IsWindowClosed(false), IsWindowClosing(true), IsNewSymbol(false)]);
    ReactionWindowStatusField afterClose = start.transform(closeWindow);

    var openWindow =
    TestResults(values: [IsWindowClosed(true), IsWindowClosing(false), IsNewSymbol(true)]);
    ReactionWindowStatusField afterOpen = afterClose.transform(openWindow);

    expect(true, ~~afterOpen);
  });

  test('RW stays closed after closing then opens on new symbol', () {
    var start = ReactionWindowStatusField(true);

    var closeWindow =
    TestResults(values: [IsWindowClosed(false), IsWindowClosing(true), IsNewSymbol(false)]);
    ReactionWindowStatusField afterClose = start.transform(closeWindow);

    var nothingWindow =
    TestResults(values: [IsWindowClosed(true), IsWindowClosing(false), IsNewSymbol(false)]);
    ReactionWindowStatusField afterNothing = afterClose.transform(nothingWindow);

    var openWindow =
    TestResults(values: [IsWindowClosed(true), IsWindowClosing(false), IsNewSymbol(true)]);
    ReactionWindowStatusField afterOpen = afterNothing.transform(openWindow);

    expect(true, ~~afterOpen);
  });

  /*
  Lives
   */

  test('Hurt player on tapping killer', (){
    var start = LivesTotalField();
  });

}
