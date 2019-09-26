import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/judge/OracleJudge.dart';
import 'package:impulse/transcribers/ITranscriber.dart';
import 'package:impulse/transcribers/Transcriber.dart';
import 'package:impulse/transcribers/impl/HurtPlayerTranscriber.dart';
import 'package:impulse/transcribers/impl/RewardPlayerTranscriber.dart';

import 'PlayerTrappedTranscriber.dart';

class PlayerReactedTranscriber extends Transcriber {
  final IOracle shouldRewardPlayer = OracleJudge();
  final ITranscriber writePlayerTapped = PlayerTrappedTranscriber();
  final ITranscriber writeHurtPlayer = HurtPlayerTranscriber();
  final ITranscriber writeRewardPlayer = RewardPlayerTranscriber();

  @override
  writeToState() {
    writePlayerTapped.writeToState();
    if (shouldRewardPlayer.getAnswer()) {
      writeRewardPlayer.writeToState();
    } else {
      writeHurtPlayer.writeToState();
    }
  }
}
