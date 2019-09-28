import 'IState.dart';

abstract class IStateBuilder {
  IState initState();
  IState buildState();
}
