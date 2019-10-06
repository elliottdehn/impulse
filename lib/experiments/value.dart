class Value<T> {
  var value;

  T operator ~() {
    return this.value;
  }

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
