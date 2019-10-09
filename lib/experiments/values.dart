import 'package:impulse/widgets/EventID.dart';

import 'value.dart';

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

class LivesTotal extends Value<int>{
  LivesTotal(int value) : super(value);
}

class ShownSymbol extends Value<String> {
  ShownSymbol(String value) : super(value);
}