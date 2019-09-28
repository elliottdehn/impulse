import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impulse/transcribers/ITranscriber.dart';
import 'package:impulse/transcribers/impl/EndGameTranscriber.dart';
import 'package:impulse/widgets/ScreenID.dart';
import 'package:impulse/widgets/app/ScreenChangeNotification.dart';

class DeathScreen extends StatelessWidget {
  DeathScreen(){
    ITranscriber endGame = EndGameTranscriber();
    endGame.writeToState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('Oops!',
            style: Theme.of(context)
                .textTheme
                .display1
                .apply(color: Color.fromRGBO(255, 255, 255, 1.0))),
        RaisedButton(
            onPressed: () {
              ScreenChangeNotification(screen: ScreenID.GAME).dispatch(context);
            },
            child:
                Text('Play Again', style: Theme.of(context).textTheme.display1))
      ],
    );
  }
}
