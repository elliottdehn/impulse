import 'dart:core';
import 'dart:core' as prefix0;
import 'dart:math';

import 'package:impulse/experiments/event_listener.dart';
import 'package:impulse/experiments/model_builder.dart';
import 'package:impulse/experiments/symbol.dart' as prefix1;
import 'package:impulse/widgets/EventID.dart';

import 'reaction.dart';
import 'stats.dart';
import 'symbol.dart';
import 'value.dart';

class GameModel implements IModelBuilder<Game>, IEventListener {
  static final GameModel _singleton = GameModel._privateConstructor();
  GameModel._privateConstructor();

  factory GameModel() {
    return _singleton;
  }

  /*
  Updaters

  For the sake of sanity, fields requiring no further logic are directly updated
   */

  @override
  onUpdate(EventID e) {
    switch (e) {
      case EventID.NEW_SYMBOL:
        //TODO: update intervals, visibility time, window time, streak
        killerSymbolTotal.updateForEventUsingFunction(e, this.symbolTotalF);
        shown.updateForEventUsingFunction(e, this.newSymbolF);
        reactionWindowClosed = false;
        shownTapCount = 0;
        break;
      case EventID.ENFORCE_TAP:
        reactionWindowClosed = true;
        break;
      case EventID.PLAYER_REACTED:
        //TODO: update streak
        shownTapCount += 1;
        normalSymbolTotal.updateForEventUsingFunction(e, this.symbolTotalF);
        // TODO: Handle this case.
        break;
      case EventID.GAME_STARTED:
        // TODO: Handle this case.
        break;
      case EventID.DISPOSE:
        // TODO: Handle this case.
        break;
    }
  }

  /*
  Creators
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
    SymbolModel symbolBuilder = new SymbolModel(_singleton);

    symbolBuilder
      ..getIntervalTimeF = symbolBuilder.getIntervalConstant
      ..getShownF = symbolBuilder.getShown
      ..getVisibilityTimeF = symbolBuilder.getVisibilityTimeConstant;

    return symbolBuilder;
  }

  IModelBuilder _createReactionBuilder() {
    ReactionModel reactionBuilder = new ReactionModel(_singleton);

    reactionBuilder
      ..reactionWindowF = reactionBuilder.getReactionWindowConstant
      ..baseReactionWindowF = reactionBuilder.getBaseReactionWindow;

    return reactionBuilder;
  }

  IModelBuilder _createStatsBuilder() {
    StatsModel statsBuilder = new StatsModel(_singleton);

    statsBuilder
      ..scoreF = statsBuilder.getScoreBasic
      ..streakF = statsBuilder.getTotalStreakBasic
      ..avgReactionF = statsBuilder.getAvgReactionTimeBasic
      ..livesF = statsBuilder.getLivesBasic;

    return statsBuilder;
  }

  /*
  State
   */

  //static members are used for fields whose initial values depend on them
  static const int _startReactionWindowConst = 700; //milliseconds
  static const int _intervalFast = 1000; //milliseconds
  static const int _intervalMedium = 2000; //milliseconds
  static const int _intervalSlow = 3000; //milliseconds
  static const List<String> killerSymbols = ["X"];
  static const List<String> normalSymbols = [
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

  final int baseReactionWindow = _startReactionWindowConst;
  final int minimumReactionWindow = 400; //milliseconds
  double reactionWindowScalar = 1.0; //multiplied to base reaction window
  int reactionWindowAdjustment = 0; //added to scaled window
  bool reactionWindowClosed = true;

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
  int minimumInterval = _startReactionWindowConst + 200; //milliseconds
  double intervalScalar = 1.0; //0.0 <-> 1.0 <-> infinity
  int intervalAdjustment = 0; //added to the final interval

  ShownState shown = new ShownState(null);
  int shownTapCount = 0;
  SymbolTotalState normalSymbolTotal = new SymbolTotalState(0);
  SymbolTotalState killerSymbolTotal = new SymbolTotalState(0);
  List<int> reactionTimes = List();
  int symbolStreak = 0;
  int lives = 3;
  int intervalIdx = 1;
  int visibilityTime = 125;

  String newSymbolF(EventID e) {
    return shown.updateSymbolConstantOdds(
        normalOdds, normalSymbols, killerSymbols);
  }

  int symbolTotalF(EventID e) {
    bool isNormal = normalSymbols.contains(~shown);
    bool isAlreadyTapped = shownTapCount > 0;
    return killerSymbolTotal.updateSymbolTotal(
        e, killerSymbolTotal, isNormal, isAlreadyTapped);
  }
}

class ShownState extends Updatable<String> {
  ShownState(value) : super(value);

  @override
  updatesOn(EventID e) {
    return EventID.NEW_SYMBOL == e;
  }

  String updateSymbolConstantOdds(
      double normalOdds, List<String> normals, List<String> killers) {
    var random = Random.secure();
    bool isNormalSymbol = random.nextDouble() <= normalOdds;
    if (isNormalSymbol) {
      return normals[random.nextInt(normals.length)];
    } else {
      return killers[random.nextInt(killers.length)];
    }
  }
}

class SymbolTotalState extends Updatable<int> {
  List<EventID> updates = [EventID.PLAYER_REACTED, EventID.NEW_SYMBOL];

  SymbolTotalState(value) : super(value);

  @override
  bool updatesOn(EventID e) {
    return updates.contains(e);
  }

  int updateSymbolTotal(EventID e, SymbolTotalState currentTotal,
      bool isNormalSymbol, bool alreadyTapped) {
    if (EventID.PLAYER_REACTED == e && !alreadyTapped && isNormalSymbol) {
      return currentTotal.value += 1;
    } else if (EventID.NEW_SYMBOL == e && !alreadyTapped && !isNormalSymbol) {
      return currentTotal.value += 1;
    } else {
      return ~currentTotal;
    }
  }
}

class Game {
  final Stats stats;
  final Symbol symbol;
  final Reaction reaction;

  const Game({this.stats, this.symbol, this.reaction});
}
