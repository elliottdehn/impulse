/*
LIFE OF AN EVENT:

presenter

->e->

model(presenter, notifier)

->s,e->

interpreter

->s,e->

predicates(s).test(e)

->results->

interpreter

->results->

model

->results->

transformer

->results->

transforms.transform(results)

->s->

transformer

->s->

model

->s, e->

notifier
*/

import 'package:impulse/experiments/state_fields.dart';
import 'package:impulse/experiments/values.dart';
import 'package:test/test.dart';

void main() {
  test('Sanity', (){
    //true means open
    ReactionWindowStatus rws = new ReactionWindowStatus(true);
    ReactionWindowStatusField rwsf = new ReactionWindowStatusField(rws);
    IsWindowClosing windowClosing = new IsWindowClosing(PredicateID.IS_WINDOW_CLOSING, true);
  });
}