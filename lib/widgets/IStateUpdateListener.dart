import 'IState.dart';

abstract class IView {
  onStateUpdate(IState newState);
}
