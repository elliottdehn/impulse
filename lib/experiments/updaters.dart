import 'dart:math';

import 'value.dart';
import 'package:impulse/widgets/EventID.dart';

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

  int updateSymbolTotal(EventID e,
      bool isNormalSymbol, bool alreadyTapped) {
    if (EventID.PLAYER_REACTED == e && !alreadyTapped && isNormalSymbol) {
      return this.value += 1;
    } else if (EventID.NEW_SYMBOL == e && !alreadyTapped && !isNormalSymbol) {
      return this.value += 1;
    } else {
      return ~this;
    }
  }
}

class LivesState extends Updatable<int> {

  List<EventID> updates = [EventID.PLAYER_REACTED, EventID.ENFORCE_TAP];
  LivesState(value) : super(value);

  @override
  bool updatesOn(EventID e) {
    return updates.contains(e);
  }

  int updateLivesMultiAllowedForNormal(EventID e, bool isNormal, bool isTapped){
    if(EventID.PLAYER_REACTED == e && !isNormal) {
      this.value -= 1;
    } else if (EventID.ENFORCE_TAP == e && isNormal && !isTapped){
      this.value -= 1;
    }
    return this.value;
  }

}