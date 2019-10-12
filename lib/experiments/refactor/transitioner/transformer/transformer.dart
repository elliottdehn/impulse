import '../predicator/test_results.dart';
import 'state_fields.dart';

class StateTransformer {
  final StateFields startState;

  StateTransformer(this.startState);

  StateFields transform(TestResults results) {
    //this orderless transform is the entire reason behind the refactor
    List<StateValueField> oldFields = startState.fields;
    List<StateValueField> newFields = [];
    for (StateValueField field in oldFields) {
      newFields.add(field.transform(results));
    }

    StateFields newStateFields = StateFields(newFields);

    return newStateFields;
  }
}

mixin Transform<T extends Transform<T>> {
  T transform(TestResults t);
}
