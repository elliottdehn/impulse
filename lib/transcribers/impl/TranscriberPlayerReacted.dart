import 'package:impulse/oracles/IOracle.dart';
import 'package:impulse/oracles/impl/judge/OracleJudge.dart';
import 'package:impulse/transcribers/ITranscriber.dart';
import 'package:impulse/transcribers/Transcriber.dart';
import 'package:impulse/transcribers/impl/TranscriberHurtPlayer.dart';
import 'package:impulse/transcribers/impl/TranscriberRewardPlayer.dart';

import 'TranscriberPlayerTapped.dart';

class TranscriberPlayerReacted extends Transcriber {

  final IOracle shouldHurtPlayer = OracleJudge();
  final ITranscriber writePlayerTapped = TranscriberPlayerTapped();
  final ITranscriber writeHurtPlayer = TranscriberHurtPlayer();
  final ITranscriber writeRewardPlayer = TranscriberRewardPlayer();

  @override
  writeToState() {
    writePlayerTapped.writeToState();
    if(shouldHurtPlayer.getAnswer()){
      writeHurtPlayer.writeToState();
    } else {
      writeRewardPlayer.writeToState();
    }
  }

}