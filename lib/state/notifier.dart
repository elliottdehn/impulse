import 'package:impulse/experiments/refactor/state_values.dart';
import 'package:impulse/widgets/IStateUpdateHandler.dart';
import 'package:impulse/state/i_notifier.dart';

class Notifier implements INotifier {

  static final Notifier _singleton =
      new Notifier._privateConstructor();

  factory Notifier() {
    return _singleton;
  }

  Notifier._privateConstructor();

  List<IStateUpdateHandler> presenters = [];

  @override
  notifyListeners(StateValues s) {
    for (IStateUpdateHandler presenter in presenters) {
      presenter.onModelChanged(s);
    }
  }

  @override
  addStateListener(IStateUpdateHandler presenter) {
    if (!presenters.contains(presenter)) {
      presenters.add(presenter);
    }
  }

  @override
  removeStateListener(IStateUpdateHandler presenter) {
    presenters.remove(presenter);
  }
}
