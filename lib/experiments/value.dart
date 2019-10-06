import 'package:impulse/widgets/EventID.dart';

class Value<T> {
  T value;

  Value(this.value);

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
  Updatable(value) : super(value);

  bool updatesOn(EventID e);

  //update
  updateForEventUsingFunction(EventID e, T Function(EventID) f){
    this.value = Function.apply(f, [e]);
  }
}
