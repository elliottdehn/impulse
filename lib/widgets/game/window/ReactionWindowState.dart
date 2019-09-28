import '../../IState.dart';

class ReactionWindowState implements IState {
  int baseReactionWindow;
  int currReactionWindow;
  bool isStopped;
  bool isReset;
}