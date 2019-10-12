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

import 'package:impulse/experiments/refactor/transitioner/predicator/test_results.dart';
import 'package:impulse/experiments/refactor/transitioner/transformer/state_fields.dart';
import 'package:test/test.dart';

void main() {
  /*
  Reaction window status
   */

  test('RW Closes on closing', () {
    var start = ReactionWindowStatusField(true);
    var tests = TestResults(values: [
      IsWindowClosed(false),
      IsWindowClosing(true),
      DidNewSymbol(false)
    ]);
    ReactionWindowStatusField result = start.transform(tests);
    expect(~result, false);
  });

  test('RW opens on new symbol after closing', () {
    var start = ReactionWindowStatusField(true);

    var closeWindow = TestResults(values: [
      IsWindowClosed(false),
      IsWindowClosing(true),
      DidNewSymbol(false)
    ]);
    ReactionWindowStatusField afterClose = start.transform(closeWindow);

    var openWindow = TestResults(values: [
      IsWindowClosed(true),
      IsWindowClosing(false),
      DidNewSymbol(true)
    ]);
    ReactionWindowStatusField afterOpen = afterClose.transform(openWindow);

    expect(~afterOpen, true);
  });

  test('RW stays closed after closing then opens on new symbol', () {
    var start = ReactionWindowStatusField(true);

    var closeWindow = TestResults(values: [
      IsWindowClosed(false),
      IsWindowClosing(true),
      DidNewSymbol(false)
    ]);
    ReactionWindowStatusField afterClose = start.transform(closeWindow);

    var nothingWindow = TestResults(values: [
      IsWindowClosed(true),
      IsWindowClosing(false),
      DidNewSymbol(false)
    ]);
    ReactionWindowStatusField afterNothing =
        afterClose.transform(nothingWindow);

    var openWindow = TestResults(values: [
      IsWindowClosed(true),
      IsWindowClosing(false),
      DidNewSymbol(true)
    ]);
    ReactionWindowStatusField afterOpen = afterNothing.transform(openWindow);

    expect(~afterOpen, true);
  });

  /*
  Lives
   */

  test('Hurt player on tapping killer window closed', () {
    var start = LivesTotalField(5);
    var hurtPlayer = TestResults(values: [
      IsKillerSymbol(true),
      DidPlayerReact(true),
      IsWindowClosed(true)
    ]);
    var end = start.transform(hurtPlayer);
    expect(~end, 4);
  });

  test('Hurt player on tapping killer window open', () {
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

  test('Hurt player on tapping killer three times', () {
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

  test('Hurt player on tapping killer window open 3 times', () {
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

  test('Do not hurt if no taps before window on killer', () {
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

  test('Hurt if no taps before window on normal symbol', () {
    var start = LivesTotalField(5);
    var hurtPlayer = TestResults(values: [
      IsTappedZero(true),
      IsWindowClosing(true),
      IsWindowClosed(false),
      IsWindowOpen(false),
      IsNormalSymbol(true)
    ]);
    var end = start.transform(hurtPlayer);
    expect(~end, 4);
  });

  test('Do not hurt if taps after window on normal symbol', () {
    var start = LivesTotalField(5);
    var nothingPlayer = TestResults(values: [
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

  test('Do not hurt if taps after window on normal symbol 2', () {
    var start = LivesTotalField(5);
    var nothingPlayer = TestResults(values: [
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

  test('Do not hurt if taps after window on normal symbol 3', () {
    var start = LivesTotalField(5);
    var nothingPlayer = TestResults(values: [
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

  /*
  tap count
   */

  test('Increase tap count for all tapping cases except new symbol', () {
    List<TestResult> isKillerCases = [
      IsKillerSymbol(true),
      IsKillerSymbol(false)
    ];
    List<TestResult> isNormalCases = [
      IsNormalSymbol(true),
      IsNormalSymbol(true)
    ];
    List<TestResult> isTapZeroCases = [IsTappedZero(true), IsTappedZero(false)];
    List<TestResult> isTapOneCases = [DidFirstTap(true), DidFirstTap(false)];
    List<TestResult> isWindowOpenCases = [
      IsWindowOpen(true),
      IsWindowOpen(false)
    ];
    List<TestResult> isWindowCloseCases = [
      IsWindowClosed(true),
      IsWindowClosed(false)
    ];
    List<TestResult> isWindowClosingCases = [
      IsWindowClosing(true),
      IsWindowClosing(false)
    ];

    for (TestResult t in isKillerCases) {
      for (TestResult t2 in isNormalCases) {
        for (TestResult t3 in isTapZeroCases) {
          for (TestResult t4 in isTapOneCases) {
            for (TestResult t5 in isWindowOpenCases) {
              for (TestResult t6 in isWindowCloseCases) {
                for (TestResult t7 in isWindowClosingCases) {
                  var start = TapCountField(0);
                  var playerTaps = [DidPlayerReact(true), DidNewSymbol(false)];
                  TestResults tr =
                      TestResults(values: [t, t2, t3, t4, t5, t6, t7]);
                  tr.addAll(playerTaps);
                  var end = start.transform(tr);
                  end = end.transform(tr);
                  end = end.transform(tr);
                  expect(~end, 3);
                }
              }
            }
          }
        }
      }
    }
  });

  test('Tap count to zero for new symbol all cases', () {
    List<TestResult> isKillerCases = [
      IsKillerSymbol(true),
      IsKillerSymbol(false)
    ];
    List<TestResult> isNormalCases = [
      IsNormalSymbol(true),
      IsNormalSymbol(true)
    ];
    List<TestResult> isTapZeroCases = [IsTappedZero(true), IsTappedZero(false)];
    List<TestResult> isTapOneCases = [DidFirstTap(true), DidFirstTap(false)];
    List<TestResult> isWindowOpenCases = [
      IsWindowOpen(true),
      IsWindowOpen(false)
    ];
    List<TestResult> isWindowCloseCases = [
      IsWindowClosed(true),
      IsWindowClosed(false)
    ];
    List<TestResult> isWindowClosingCases = [
      IsWindowClosing(true),
      IsWindowClosing(false)
    ];

    for (TestResult t in isKillerCases) {
      for (TestResult t2 in isNormalCases) {
        for (TestResult t3 in isTapZeroCases) {
          for (TestResult t4 in isTapOneCases) {
            for (TestResult t5 in isWindowOpenCases) {
              for (TestResult t6 in isWindowCloseCases) {
                for (TestResult t7 in isWindowClosingCases) {
                  var start = TapCountField(100);
                  var playerTaps = [DidPlayerReact(false), DidNewSymbol(true)];
                  TestResults tr =
                      TestResults(values: [t, t2, t3, t4, t5, t6, t7]);
                  tr.addAll(playerTaps);
                  var end = start.transform(tr);
                  expect(~end, 0);
                  end = end.transform(tr);
                  expect(~end, 0);
                  end = end.transform(tr);
                  expect(~end, 0);
                }
              }
            }
          }
        }
      }
    }
  });

  /*
  normal count
   */

  test('Increase normal count one for first tap', () {
    var start = NormalSymbolTotalField(0);
    var tr = TestResults(values: [IsNormalSymbol(true), DidFirstTap(true), IsWindowOpen(true)]);
    var end = start.transform(tr);
    expect(~end, 1);
  });

  test('Negative cases', (){
    var start = NormalSymbolTotalField(0);
    var tr2 = TestResults(values: [IsNormalSymbol(false), DidFirstTap(true), IsWindowOpen(true)]);
    var tr3 = TestResults(values: [IsNormalSymbol(false), DidFirstTap(false), IsWindowOpen(true)]);
    var tr1 = TestResults(values: [IsNormalSymbol(false), DidFirstTap(false), IsWindowOpen(false)]);
    var tr4 = TestResults(values: [IsNormalSymbol(true), DidFirstTap(false), IsWindowOpen(true)]);
    var tr6 = TestResults(values: [IsNormalSymbol(false), DidFirstTap(true), IsWindowOpen(false)]);
    var tr5 = TestResults(values: [IsNormalSymbol(true), DidFirstTap(false), IsWindowOpen(false)]);
    var tr7 = TestResults(values: [IsNormalSymbol(true), DidFirstTap(true), IsWindowOpen(false)]);
    List<TestResults> trs = [tr1, tr2, tr3, tr4, tr5, tr6, tr7];
    var end;
    for(TestResults tr in trs) {
      end = start.transform(tr);
    }
    expect(~end, 0);
  });

  /*
  killer count
   */

  test('Increase killer count for not tapping', (){
    var start = KillerSymbolTotalField(0);
    var tr = TestResults(values: [
      IsKillerSymbol(true),
      DidNewSymbol(true),
      IsTappedZero(true)
    ]);
    var end = start.transform(tr);
    expect(~end, 1);
  });

  /*
  reaction window length
   */

  /*
  interval
   */

  /*
  score
   */

  test('basic test for each field', () {
    //all of these fields are expected to change outside and inside
    var startN = NormalSymbolTotalField(0);
    var startK = KillerSymbolTotalField(0);
    var startTC = TapCountField(0);

    var startScore = ScoreField(0, startTC, startN, startK);

    //this is not a valid case. it is meant to test the limits of the method
    var trs = TestResults(values: [
      IsKillerSymbol(true),
      IsNormalSymbol(true),
      IsTappedZero(true),
      DidFirstTap(true),
      IsWindowOpen(true),
      DidNewSymbol(true),
      DidPlayerReact(false),
      IsEasy(true)
    ]);

    var endScore = startScore.transform(trs);
    assert(~endScore != startScore);
  });

  /*
  symbol
   */
}
