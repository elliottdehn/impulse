import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/judge/OracleJudge.dart';
import 'package:impulse/state/AppStateStore.dart';
import 'package:impulse/transcribers/ITranscriber.dart';
import 'package:impulse/transcribers/impl/HurtPlayerTranscriber.dart';

import '../Transcriber.dart';

class EnforceWindowTranscriber extends Transcriber {

  final ITranscriber hurtPlayer = HurtPlayerTranscriber();
  final IOracle shouldRewardPlayer = OracleJudge();

  @override
  writeToState() {
    if(!shouldRewardPlayer.getAnswer()){
      hurtPlayer.writeToState();
    }
    manager.updateState(AppStateKey.REACTION_WINDOW_CLOSED, true);
  }

}