import 'IState.dart';

abstract class IView {
  onStateUpdate(IViewState newState);
}
