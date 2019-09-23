import 'IState.dart';

abstract class IStateUpdateListener {
  onStateUpdate(IState newState);
}