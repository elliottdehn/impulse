import 'package:impulse/experiments/game.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:test/test.dart';

void main(){
  test('Game model created', () {
    GameModel gm = GameModel();
    assert(gm != null);
  });

  test('Game model is singleton', () {
    GameModel gm1 = GameModel();
    GameModel gm2 = GameModel();
    gm1.shownTapCount = 3;

    int gm1TapCount = gm1.shownTapCount;
    int gm2TapCount = gm2.shownTapCount;
    expect(3, gm1TapCount);
    expect(3, gm2TapCount);
    assert(gm1 == gm2);
  });

  test('Game model resets on start game', () {
    GameModel gm = GameModel();
    int tapCountInit = gm.shownTapCount;
    gm.shownTapCount = 3;
    gm.onUpdate(EventID.GAME_STARTED);
    int tapCountPostReset = gm.shownTapCount;
    expect(tapCountPostReset, tapCountInit);
  });
}