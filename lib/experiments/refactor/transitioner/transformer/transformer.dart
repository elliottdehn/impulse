import 'package:flutter/rendering.dart';

import '../predicator/test_results.dart';
import 'transformers.dart';

class StateTransformer {
  final StateFields startState;
  StateFields currState;

  StateTransformer(this.startState);

  StateFields transform(TestResults results) {
    if (currState == null) {
      currState = startState;
    }
    //this orderless transform is the entire reason behind the refactor
    List<StateValueField> oldFields = currState.fields;
    List<StateValueField> newFields = [];
    for (StateValueField field in oldFields) {
      newFields.add(field.transform(results));
    }

    currState = StateFields(newFields);

    return currState;
  }
}

mixin Transform<T extends Transform<T>> {
  T transform(TestResults t);
}
