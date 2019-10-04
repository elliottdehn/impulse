import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/judge/OracleJudge.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/transcribers/ITranscriber.dart';
import 'package:impulse/transcribers/Transcriber.dart';
import 'package:impulse/transcribers/impl/HurtPlayerTranscriber.dart';
import 'package:impulse/transcribers/impl/RewardPlayerTranscriber.dart';

import 'PlayerTappedTranscriber.dart';

class PlayerReactedTranscriber extends Transcriber {
  final IOracle shouldRewardPlayer = OracleJudge();
  final ITranscriber writePlayerTapped = PlayerTappedTranscriber();
  final ITranscriber writeHurtPlayer = HurtPlayerTranscriber();
  final ITranscriber writeRewardPlayer = RewardPlayerTranscriber();

  @override
  writeToState() {
    writePlayerTapped.writeToState();
    int taps = manager.getStateValue(AppStateKey.SYMBOL_TAPPED_COUNT);
    if(taps == 1) {
      if (shouldRewardPlayer.getAnswer()) {
        writeRewardPlayer.writeToState();
      } else {
        writeHurtPlayer.writeToState();
      }
    }
  }
}
