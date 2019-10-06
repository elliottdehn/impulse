import 'package:impulse/widgets/EventID.dart';

class Value<T> {
  var value;

  //"get value""
  T operator ~() {
    return this.value;
  }

  //"set value"
  operator <<(T source) {
    this.value = source;
  }

  bool operator ==(Object that) {
    if (that is Value) {
      Value thatValue = that;
      return ~this == ~thatValue;
    } else {
      return false;
    }
  }

  int get hashCode {
    if (value != null) {
      return value.hashCode;
    } else {
      return 0;
    }
  }
}

abstract class Updatable<T> extends Value {
  update(EventID e);
}
