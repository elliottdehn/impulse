import 'package:impulse/experiments/refactor/id/event_id.dart';

import 'values.dart';

abstract class Updatable<T> extends Value {
  Updatable(value) : super(value);

  bool updatesOn(EventID e);

  //update
  updateForEventUsingFunction(EventID e, T Function(EventID) f) {
    this.value = Function.apply(f, [e]);
  }
}
