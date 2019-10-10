import 'package:impulse/widgets/EventID.dart';

class Value<T> {
  T value;

  Value(this.value);

  //"get value"
  T operator ~() {
    return this.value;
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

class RandomSeed extends Value<int> {
  RandomSeed(int value) : super(value);
}

class IntervalLength extends Value<int> {
  IntervalLength(int value) : super(value);
}

class TapCount extends Value<int> {
  TapCount(int value) : super(value);
}

class Event extends Value<EventID> {
  Event(EventID value) : super(value);
}

class NormalSymbolTotal extends Value<int> {
  NormalSymbolTotal(int value) : super(value);
}

class KillerSymbolTotal extends Value<int> {
  KillerSymbolTotal(int value) : super(value);
}

class LivesTotal extends Value<int> {
  LivesTotal(int value) : super(value);
}

class ShownSymbol extends Value<String> {
  ShownSymbol(String value) : super(value);
}

class ReactionWindowStatus extends Value<bool> {
  ReactionWindowStatus(bool value) : super(value);
}

class ReactionWindowLength extends Value<int> {
  ReactionWindowLength(int value) : super(value);
}

class Minimum extends Value<num> {
  Minimum(num value) : super(value);
}

class Maximum extends Value<num> {
  Maximum(num value) : super(value);
}

class Scalar extends Value<num> {
  Scalar(num value) : super(value);
}

class Multiplier extends Value<num> {
  Multiplier(num value) : super(value);
}

class Adjust extends Value<num> {
  Adjust(num value) : super(value);
}

class Variant extends Value<num> {
  Variant(num value) : super(value);
}

//old

class Score extends Value<int> {
  Score(int value) : super(value);
}

class AvgReaction extends Value<int> {
  AvgReaction(int value) : super(value);
}

class Streak extends Value<int> {
  Streak(int value) : super(value);
}

class Lives extends Value<int> {
  Lives(int value) : super(value);
}

class Reaction {
  final ReactionWindow reactionWindow;
  final BaseReactionWindow baseReactionWindow;

  const Reaction({this.reactionWindow, this.baseReactionWindow});
}

class ReactionWindow extends Value<int> {
  ReactionWindow(int value) : super(value);
}

class BaseReactionWindow extends Value<int> {
  BaseReactionWindow(int value) : super(value);
}

class IsStopped extends Value<bool> {
  IsStopped(bool value) : super(value);
}

class IsReset extends Value<bool> {
  IsReset(bool value) : super(value);
}
