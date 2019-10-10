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
    expect(~result, false);
  });

  test('RW opens on new symbol after closing', () {
    var start = ReactionWindowStatusField(true);

    var closeWindow =
    TestResults(values: [IsWindowClosed(false), IsWindowClosing(true), IsNewSymbol(false)]);
    ReactionWindowStatusField afterClose = start.transform(closeWindow);

    var openWindow =
    TestResults(values: [IsWindowClosed(true), IsWindowClosing(false), IsNewSymbol(true)]);
    ReactionWindowStatusField afterOpen = afterClose.transform(openWindow);

    expect(~afterOpen, true);
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

    expect(~afterOpen, true);
  });

  /*
  Lives
   */

  test('Hurt player on tapping killer window closed', (){
    var start = LivesTotalField(5);
    var hurtPlayer = TestResults(values: [
      IsKillerSymbol(true),
      DidPlayerReact(true),
      IsWindowClosed(true)
    ]);
    var end = start.transform(hurtPlayer);
    expect(~end, 4);
  });

  test('Hurt player on tapping killer window open', (){
    var start = LivesTotalField(5);
    var hurtPlayer = TestResults(values: [
      IsKillerSymbol(true),
      DidPlayerReact(true),
      IsWindowClosed(false),
      IsWindowClosing(false),
      IsWindowOpen(true)
    ]);
    var end = start.transform(hurtPlayer);
    expect(~end, 4);
  });

  test('Hurt player on tapping killer three times', (){
    var start = LivesTotalField(5);
    var hurtPlayer = TestResults(values: [
      IsKillerSymbol(true),
      DidPlayerReact(true),
      IsWindowClosed(true)
    ]);
    var end = start.transform(hurtPlayer);
    end = end.transform(hurtPlayer);
    end = end.transform(hurtPlayer);
    expect(~end, 2);
  });

  test('Hurt player on tapping killer window open 3 times', (){
    var start = LivesTotalField(5);
    var hurtPlayer = TestResults(values: [
      IsKillerSymbol(true),
      DidPlayerReact(true),
      IsWindowClosed(false),
      IsWindowClosing(false),
      IsWindowOpen(true)
    ]);
    var end = start.transform(hurtPlayer);
    end = end.transform(hurtPlayer);
    end = end.transform(hurtPlayer);
    expect(~end, 2);
  });

  test('Do not hurt if no taps before window on killer', (){
    var start = LivesTotalField(5);
    var nothingToPlayer = TestResults(values: [
      IsKillerSymbol(true),
      DidPlayerReact(false),
      IsWindowClosed(false),
      IsWindowClosing(true),
      IsTappedZero(true)
    ]);
    var end = start.transform(nothingToPlayer);
    end = end.transform(nothingToPlayer);
    end = end.transform(nothingToPlayer);
    expect(~end, 5);
  });

  test('Hurt if no taps before window on normal symbol', (){
    var start = LivesTotalField(5);
    var hurtPlayer = TestResults(values:[
      IsTappedZero(true),
      IsWindowClosing(true),
      IsWindowClosed(false),
      IsWindowOpen(false),
      IsNormalSymbol(true)
    ]);
    var end = start.transform(hurtPlayer);
    expect(~end, 4);
  });

  test('Do not hurt if taps after window on normal symbol', (){
    var start = LivesTotalField(5);
    var nothingPlayer = TestResults(values:[
      IsTappedZero(true),
      IsWindowClosing(false),
      IsWindowClosed(true),
      IsWindowOpen(false),
      IsNormalSymbol(true),
      DidPlayerReact(true),
    ]);
    var end = start.transform(nothingPlayer);
    expect(~end, 5);
  });

  test('Do not hurt if taps after window on normal symbol 2', (){
    var start = LivesTotalField(5);
    var nothingPlayer = TestResults(values:[
      IsTappedZero(false),
      IsWindowClosing(false),
      IsWindowClosed(true),
      IsWindowOpen(false),
      IsNormalSymbol(true),
      DidPlayerReact(true),
    ]);
    var end = start.transform(nothingPlayer);
    expect(~end, 5);
  });

  test('Do not hurt if taps after window on normal symbol 3', (){
    var start = LivesTotalField(5);
    var nothingPlayer = TestResults(values:[
      IsTappedZero(true),
      DidFirstTap(true),
      IsWindowClosing(false),
      IsWindowClosed(true),
      IsWindowOpen(false),
      IsNormalSymbol(true),
      DidPlayerReact(true),
    ]);
    var end = start.transform(nothingPlayer);
    expect(~end, 5);
  });
}
