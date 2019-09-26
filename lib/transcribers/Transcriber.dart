import 'package:impulse/state/AppStateManager.dart';
import 'package:impulse/state/IAppStateManager.dart';
import 'package:impulse/transcribers/ITranscriber.dart';

abstract class Transcriber implements ITranscriber {
  final IAppStateManager manager = AppStateManager();
}
