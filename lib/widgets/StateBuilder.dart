import 'package:impulse/state/notifier.dart';
import 'package:impulse/state/i_notifier.dart';
import 'package:impulse/widgets/IStateBuilder.dart';

abstract class StateBuilder implements IStateBuilder {
  final INotifier manager = Notifier();
}
