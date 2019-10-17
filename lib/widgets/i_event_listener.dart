import 'package:impulse/experiments/refactor/id/event_id.dart';

abstract class IEventListener {
  onEvent(EventID id);
}
