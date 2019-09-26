import 'package:impulse/widgets/EventID.dart';

abstract class IEventListener {
  onEvent(EventID id);
}