import 'package:impulse/widgets/IPresenter.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/game/score/ScoreStateBuilder.dart';

class ScoreWidgetPresenter implements IPresenter {

  final ScoreStateBuilder stateBuilder = ScoreStateBuilder();
  @override
  IState initState() {
    return stateBuilder.initState();
  }

}