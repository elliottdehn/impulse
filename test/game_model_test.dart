import 'package:impulse/experiments/game.dart';
import 'package:impulse/experiments/updaters.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:test/test.dart';

/*
Things to make into fixture methods:
- Start the game, set it to killer
- tap(x)
 */

//! <-- Indicates that the test uncovered a bug I fixed
void main() {
  /*
  Helpers
   */

  //return start lives
  int _setToSymbol(GameModel gm, {bool isNormal}){
    int startLives = ~gm.state.lives;
    gm.onUpdate(EventID.NEW_SYMBOL);
    if (isNormal != null && !isNormal) {
      gm.state.shown = new ShownState(gm.state.killerSymbols[0]);
    } else {
      gm.state.shown = new ShownState(gm.state.normalSymbols[0]);
    }
    return startLives;
  }

  //return start lives
  int _startGameWithSymbolType(GameModel gm, {bool isNormal}) {
    gm.onUpdate(EventID.GAME_STARTED);
    return _setToSymbol(gm, isNormal: isNormal);
  }

  //I know this is pants-on-head but I don't like the other iterator options
  List listN(int i) {
    return Iterable<int>.generate(i).toList();
  }

  //return end lives
  int _tapX(GameModel gm, int i) {
    for (int temp in listN(i)) {
      gm.onUpdate(EventID.PLAYER_REACTED);
    }
    return ~gm.state.lives;
  }

  void _apply(GameModel gm, List<EventID> events) {
    for (EventID e in events) {
      gm.onUpdate(e);
    }
  }

  String getNormalSymbol(GameModel gm){
    return gm.state.normalSymbols[0];
  }

  String getKillerSymbol(GameModel gm){
    return gm.state.killerSymbols[0];
  }

  //return expected lives lost
  int _doRound(GameModel gm, bool normal, {int preWindowTaps = 0, int postWindowTaps = 0, int times = 1}){
    for(int idx in listN(times)) {
      gm.onUpdate(EventID.NEW_SYMBOL);
      String symbol = normal ? getNormalSymbol(gm) : getKillerSymbol(gm);
      gm.state.shown = new ShownState(symbol);

      _tapX(gm, preWindowTaps);
      gm.onUpdate(EventID.ENFORCE_TAP);
      _tapX(gm, postWindowTaps);
    }

    if (!normal) {
      return preWindowTaps + postWindowTaps;
    } else {
      return preWindowTaps == 0 ? 1 : 0;
    }
  }

  int _doRoundNoTap(GameModel gm, {bool isNormal, int times = 1}){
    return _doRound(gm, isNormal, preWindowTaps: 0, postWindowTaps: 0, times: times);
  }

  int _doRoundPreTap(GameModel gm, {bool isNormal, int times = 1}){
    return _doRound(gm, isNormal, preWindowTaps: 1, postWindowTaps: 0, times: times);
  }

  int _doRoundPostTap(GameModel gm, {bool isNormal, int times = 1}){
    return _doRound(gm, isNormal, preWindowTaps: 0, postWindowTaps: 1, times: times);
  }



  /*
  "Meta" tests
   */

  test('Game model created', () {
    GameModel gm = GameModel();
    assert(gm != null);
  });

  test('Game model is singleton', () {
    GameModel gm1 = GameModel();
    GameModel gm2 = GameModel();
    gm1.state.shownTapCount = 3;

    int gm1TapCount = gm1.state.shownTapCount;
    int gm2TapCount = gm2.state.shownTapCount;
    expect(3, gm1TapCount);
    expect(3, gm2TapCount);
    assert(gm1 == gm2);
  });

  //!
  test('Game state resets on start game', () {
    GameModel gm = GameModel();
    int tapCountInit = gm.state.i;
    gm.state.i += 1;
    _apply(gm, [EventID.GAME_STARTED]);
    int tapCountPostReset = gm.state.i;
    expect(tapCountPostReset, tapCountInit);
  });

  /*
  Before window
   */

  test('Hurt player on tapping killer symbol', () {
    GameModel gm = GameModel();
    int startLives = _startGameWithSymbolType(gm, isNormal: false);
    int endLives = _tapX(gm, 1);
    expect(endLives, startLives - 1);
  });

  test('Hurt player twice on tapping killer symbol twice', () {
    GameModel gm = GameModel();
    int startLives = _startGameWithSymbolType(gm, isNormal: false);
    int endLives = _tapX(gm, 2);
    expect(endLives, startLives - 2);
  });

  test('Hurt player once on failing to tap normal in time', () {
    GameModel gm = GameModel();
    int startLives = _startGameWithSymbolType(gm, isNormal: true);
    _apply(gm, [EventID.ENFORCE_TAP]);
    int endLives = ~gm.state.lives;
    expect(endLives, startLives - 1);
  });

  test('Do not hurt player for multiple taps on normal', () {
    GameModel gm = GameModel();
    int startLives = _startGameWithSymbolType(gm, isNormal: true);
    int endLives = _tapX(gm, 3);
    expect(endLives, startLives);
  });

  //!
  test('Increase normal symbol count for successful tap', () {
    GameModel gm = GameModel();
    _startGameWithSymbolType(gm, isNormal: true);
    int startTotal = ~gm.state.normalSymbolTotal;
    _tapX(gm, 1);
    int endTotal = ~gm.state.normalSymbolTotal;
    expect(endTotal, startTotal + 1);
  });

  //!
  test('Increase normal symbol count one for multiple successful tap', () {
    GameModel gm = GameModel();
    _startGameWithSymbolType(gm, isNormal: true);
    int startTotal = ~gm.state.normalSymbolTotal;
    _tapX(gm, 4);
    int endTotal = ~gm.state.normalSymbolTotal;
    expect(endTotal, startTotal + 1);
  });

  //!
  test('Increase killer symbol count one for not tapping before symbol.', () {
    GameModel gm = GameModel();
    _startGameWithSymbolType(gm, isNormal: false);
    int startTotal = ~gm.state.killerSymbolTotal;
    _apply(gm, [EventID.ENFORCE_TAP, EventID.NEW_SYMBOL]);
    int endTotal = ~gm.state.killerSymbolTotal;
    expect(endTotal, startTotal + 1);
  });

  //!
  test('Do nothing on tap before new symbol', () {
    GameModel gm = GameModel();
    _apply(gm, [EventID.GAME_STARTED]);
    int startLives = ~gm.state.lives;
    int startNormalTotal = ~gm.state.normalSymbolTotal;
    int startKillerTotal = ~gm.state.killerSymbolTotal;
    _tapX(gm, 14);
    int endLives = ~gm.state.lives;
    int endNormalTotal = ~gm.state.normalSymbolTotal;
    int endKillerTotal = ~gm.state.killerSymbolTotal;
    expect(endLives, startLives);
    expect(endNormalTotal, startNormalTotal);
    expect(endKillerTotal, startKillerTotal);
  });

  test('Totals and taps zero at start', () {
    GameModel gm = GameModel();
    _apply(gm, [EventID.GAME_STARTED]);
    expect(~gm.state.killerSymbolTotal, 0);
    expect(~gm.state.normalSymbolTotal, 0);
    expect(gm.state.shownTapCount, 0);
  });

  /*
  After window
   */

  test('Do not hurt player tapping after window but tapped before', () {
    GameModel gm = GameModel();
    int startLives = _startGameWithSymbolType(gm, isNormal: true);
    _apply(gm,
        [EventID.PLAYER_REACTED, EventID.ENFORCE_TAP, EventID.PLAYER_REACTED]);
    int endLives = ~gm.state.lives;
    expect(endLives, startLives);
  });

  test('Do not hurt player tapping after window but did not tap before', () {
    GameModel gm = GameModel();
    int startLives = _startGameWithSymbolType(gm, isNormal: true);
    _apply(gm, [EventID.ENFORCE_TAP, EventID.PLAYER_REACTED]);
    int endLives = ~gm.state.lives;
    expect(endLives, startLives - 1);
  });

  test('Do not hurt player for multiple taps before & after', () {
    GameModel gm = GameModel();
    int startLives = _startGameWithSymbolType(gm, isNormal: true);
    _tapX(gm, 3);
    _apply(gm, [EventID.ENFORCE_TAP]);
    int endLives = _tapX(gm, 3);
    expect(endLives, startLives);
  });

  //!
  test('Increase normal symbol count one for multiple before & after', () {
    GameModel gm = GameModel();
    _startGameWithSymbolType(gm, isNormal: true);
    int startTotal = ~gm.state.normalSymbolTotal;
    _doRound(gm, true, preWindowTaps: 4, postWindowTaps: 4);
    int endTotal = ~gm.state.normalSymbolTotal;
    expect(endTotal, startTotal + 1);
    int endKillerTotal = ~gm.state.killerSymbolTotal; //sanity check
    expect(endKillerTotal, 0);
  });

  /*
  Round sequence tests
   */

  test('NormalNo, NormalNo, KillerYes -> expected lost lives', () {
    GameModel gm = GameModel();
    gm.onUpdate(EventID.GAME_STARTED);
    int startLives = ~gm.state.lives;
    int expectedLostLives = 0;
    expectedLostLives += _doRoundNoTap(gm, isNormal: true);
    expectedLostLives += _doRoundNoTap(gm, isNormal: true);
    expectedLostLives += _doRoundPreTap(gm, isNormal: false);
    int endLives = ~gm.state.lives;
    int endNormalTotal = ~gm.state.normalSymbolTotal;
    int endKillerTotal = ~gm.state.killerSymbolTotal;
    expect(endLives, startLives - expectedLostLives);
    expect(endNormalTotal, 0);
    expect(endKillerTotal, 0);
  });

  //!
  test('Long case, expect no lives lost and correct totals', (){
    GameModel gm = GameModel();
    gm.onUpdate(EventID.GAME_STARTED);
    int startLives = ~gm.state.lives;
    int expectedLostLives = 0;

    expectedLostLives += _doRoundPreTap(gm, isNormal: true, times: 50);
    expectedLostLives += _doRoundNoTap(gm, isNormal: false, times: 50);
    expectedLostLives += _doRoundPreTap(gm, isNormal: true, times: 1);
    expectedLostLives += _doRoundNoTap(gm, isNormal: false, times: 1);
    expectedLostLives += _doRoundPreTap(gm, isNormal: true, times: 1);
    expectedLostLives += _doRoundNoTap(gm, isNormal: false, times: 1);
    expectedLostLives += _doRoundPreTap(gm, isNormal: true, times: 1);
    expectedLostLives += _doRoundNoTap(gm, isNormal: false, times: 1);
    expectedLostLives += _doRoundPreTap(gm, isNormal: true, times: 50);
    expectedLostLives += _doRoundNoTap(gm, isNormal: false, times: 1);
    expectedLostLives += _doRoundPreTap(gm, isNormal: true, times: 1);
    expectedLostLives += _doRoundNoTap(gm, isNormal: false, times: 50);
    expectedLostLives += _doRoundPreTap(gm, isNormal: true, times: 1);
    int resultNormalTotal = ~gm.state.normalSymbolTotal; //28 normal
    int resultKillerTotal = ~gm.state.killerSymbolTotal; //22 killer
    int endLives = ~gm.state.lives;
    int resultLostLives = startLives - endLives;
    expect(expectedLostLives, 0); //sanity check to test my own testing logic
    expect(resultLostLives, expectedLostLives);
    expect(resultNormalTotal, 105);
    expect(resultKillerTotal, 104);
  });

}
