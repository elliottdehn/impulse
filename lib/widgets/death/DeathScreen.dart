import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impulse/widgets/game/GameScreen.dart';

class DeathScreen extends StatelessWidget {

  final int _score;
  final int _streak;
  final int _avgReaction;

  DeathScreen(this._score, this._streak, this._avgReaction);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Oops!',
          style: Theme.of(context).textTheme.display1.apply(color: Color.fromRGBO(255, 255, 255, 1.0))
        ),
        RaisedButton(
          onPressed: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return GameScreen();
                }
              )
            );
          },
          child: Text(
            'Play Again',
              style: Theme.of(context).textTheme.display1
          )
        )
      ],
    );
  }
}