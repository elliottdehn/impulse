import 'dart:core';

import 'package:impulse/experiments/event_listener.dart';
import 'package:impulse/experiments/model_builder.dart';
import 'package:impulse/widgets/EventID.dart';

import 'reaction.dart';
import 'stats.dart';
import 'symbol.dart';
import 'updaters.dart';

class GameModel implements IModelBuilder<Game>, IEventListener {
  //Singleton that can have its data cleared and reset
  static GameModel _singleton = GameModel._privateConstructor();
  static GameState gs = new GameState();

  factory GameModel() {
    if(gs == null){
      gs = new GameState();
    }
      return _singleton;
  }

  GameModel._privateConstructor();

  get state {
    return gs;
  }

  _reset(){
    gs = new GameState();
  }

  /*
  Update
   */

  @override
  Game onUpdate(EventID e) {
    switch (e) {
      case EventID.NEW_SYMBOL:
        //TODO: update intervals, visibility time, window time, streak
        gs.isGameStarted = true;
        gs.killerSymbolTotal.updateForEventUsingFunction(e, this.symbolTotalF);
        gs.shown.updateForEventUsingFunction(e, this.newSymbolF);
        gs.reactionWindowClosed = false;
        gs.shownTapCount = 0;
        break;
      case EventID.ENFORCE_TAP:
        gs.reactionWindowClosed = true;
        gs.lives.updateForEventUsingFunction(e, livesF);
        break;
      case EventID.PLAYER_REACTED:
        //TODO: update streak
        gs.shownTapCount += 1;
        gs.normalSymbolTotal.updateForEventUsingFunction(e, this.symbolTotalF);
        gs.lives.updateForEventUsingFunction(e, livesF);
        break;
      case EventID.GAME_STARTED:
        _reset();
        break;
      case EventID.DISPOSE:
        // For now: do nothing (info is used on death screen)
        break;
    }
    return build();
  }

  /*
  Create
   */

  @override
  Game build() {
    IModelBuilder symbolBuilder = _createSymbolBuilder();
    IModelBuilder reactionBuilder = _createReactionBuilder();
    IModelBuilder statsBuilder = _createStatsBuilder();

    return new Game(
        symbol: symbolBuilder.build(),
        reaction: reactionBuilder.build(),
        stats: statsBuilder.build());
  }

  IModelBuilder _createSymbolBuilder() {
    SymbolModel symbolBuilder = new SymbolModel(gs);

    symbolBuilder
      ..getIntervalTimeF = symbolBuilder.getIntervalConstant
      ..getShownF = symbolBuilder.getShown
      ..getVisibilityTimeF = symbolBuilder.getVisibilityTimeConstant;

    return symbolBuilder;
  }

  IModelBuilder _createReactionBuilder() {
    ReactionModel reactionBuilder = new ReactionModel(gs);

    reactionBuilder
      ..reactionWindowF = reactionBuilder.getReactionWindowConstant
      ..baseReactionWindowF = reactionBuilder.getBaseReactionWindow;

    return reactionBuilder;
  }

  IModelBuilder _createStatsBuilder() {
    StatsModel statsBuilder = new StatsModel(gs);

    statsBuilder
      ..scoreF = statsBuilder.getScoreBasic
      ..streakF = statsBuilder.getTotalStreakBasic
      ..avgReactionF = statsBuilder.getAvgReactionTimeBasic
      ..livesF = statsBuilder.getLivesBasic;

    return statsBuilder;
  }

  String newSymbolF(EventID e) {
    return gs.shown.updateSymbolConstantOdds(
        gs.normalOdds, gs.normalSymbols, gs.killerSymbols);
  }

  int symbolTotalF(EventID e) {
    bool normalContains = gs.normalSymbols.contains(~gs.shown);
    bool killerContains = gs.killerSymbols.contains(~gs.shown);
    bool tappedOnce = gs.shownTapCount == 1;
    bool tappedZero = gs.shownTapCount == 0;
    //TODO: Fix this stupid shit, fuckhead. It sucks.
    //I know, I'm sorry :( I am writing tests so I can refactor. Just wait.
    if(EventID.PLAYER_REACTED == e){
      return gs.normalSymbolTotal.updateSymbolTotal(e, normalContains, killerContains, tappedOnce, tappedZero);
    } else if (EventID.NEW_SYMBOL == e){
      return gs.killerSymbolTotal.updateSymbolTotal(e, normalContains, killerContains, tappedOnce, tappedZero);
    } else {
      return 0;
    }
  }

  int livesF(EventID e){
    bool normalContains = gs.normalSymbols.contains(~gs.shown);
    bool killerContains = gs.killerSymbols.contains(~gs.shown);
    bool isTapped = gs.shownTapCount > 0;
    return gs.lives.updateLivesMultiAllowedForNormal(e, normalContains, killerContains, isTapped);
  }
}

class GameState {
  int i = 1; //for a test

  /*
  State
   */

  //static members are used for fields whose initial values depend on them
  static const int _startReactionWindowConst = 700; //milliseconds
  static const int _intervalFast = 1000; //milliseconds
  static const int _intervalMedium = 2000; //milliseconds
  static const int _intervalSlow = 3000; //milliseconds
  final List<String> killerSymbols = ["X"];
  final List<String> normalSymbols = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "Y",
    "Z"
  ];

  bool isGameStarted = false;

  final int baseReactionWindow = _startReactionWindowConst;
  final int minimumReactionWindow = 400; //milliseconds
  double reactionWindowScalar = 1.0; //multiplied to base reaction window
  int reactionWindowAdjustment = 0; //added to scaled window
  bool reactionWindowClosed = true;
  Stopwatch reactionStopwatch;

  final double baseNormalOdds = 0.8;
  double normalOdds = 0.8;
  double normalOddsScalar = 1.0;
  double normalOddsAdjustment = 0;

  final intervalFast = _intervalFast;
  final intervalMedium = _intervalMedium;
  final intervalSlow = _intervalSlow;
  final List<int> intervals = [
    //slowest -> fastest
    _intervalSlow,
    _intervalMedium,
    _intervalFast
  ];
  int intervalIdx = 1;
  int minimumInterval = _startReactionWindowConst + 200; //milliseconds
  double intervalScalar = 1.0; //0.0 <-> 1.0 <-> infinity
  int intervalAdjustment = 0; //added to the final interval

  ShownState shown = new ShownState(null);
  int shownTapCount = 0;
  SymbolTotalState normalSymbolTotal = new SymbolTotalState(0);
  SymbolTotalState killerSymbolTotal = new SymbolTotalState(0);
  List<int> reactionTimes = List();
  int symbolStreak = 0;
  LivesState lives = LivesState(3);
  int visibilityTime = 125;
}


class Game {
  final Stats stats;
  final Symbol symbol;
  final Reaction reaction;

  const Game({this.stats, this.symbol, this.reaction});
}
