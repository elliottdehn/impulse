import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:impulse/widgets/EventID.dart';
import 'package:impulse/widgets/IState.dart';
import 'package:impulse/widgets/game/symbol/SymbolWidget.dart';
import 'package:impulse/widgets/game/symbol/SymbolWidgetPresenter.dart';

import '../../IStateUpdateListener.dart';
import 'SymbolState.dart';

class SymbolWidgetState extends State<SymbolWidget>
    implements IStateUpdateListener {
  SymbolWidgetPresenter _presenter;
  bool created = false;

  String _symbol;
  double _opacity;
  Timer _symbolVisibilityTimer; //auto-events
  Timer _symbolIntervalTimer;

  SymbolWidgetState() {
    _presenter = new SymbolWidgetPresenter(this);
  }

  @override
  initState() {
    super.initState();
    _opacity = 0.0;
  }
  //when to damage you
  //displaying the lives
  //how to damage you?
  //timer issues

  @override
  onStateUpdate(IState newState) {
    SymbolState newStateSymbol = newState as SymbolState;
    _opacity = 1.0;
    _symbol = newStateSymbol.symbol;

    _symbolVisibilityTimer = new Timer(
        Duration(milliseconds: newStateSymbol.visibilityDuration),
            () => _onSymbolHide());

    print(newStateSymbol.nextSymbolInterval.toString() + "\n");
    _symbolIntervalTimer = new Timer(
        Duration(milliseconds: newStateSymbol.nextSymbolInterval),
            () => _onNewSymbol());

    if(created) {
      setState(() {});
    }
  }

  _onReact() {
    _presenter.onEvent(EventID.PLAYER_REACTED);
  }

  _onNewSymbol() {
    String time = new DateTime.now().toIso8601String();
    print(time + "\n");
    _presenter.onEvent(EventID.NEW_SYMBOL);
  }

  _onSymbolHide() {
    _opacity = 0.0;
    if(created) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    created = true;
    return GestureDetector(
      onTapDown: (TapDownDetails t) {
        _onReact();
      },
      child: Scaffold(
        body: Opacity(
          opacity: _opacity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('$_symbol',
                    style: Theme.of(context).textTheme.display1.apply(
                        fontSizeFactor: 8.0,
                        color: Color.fromRGBO(0, 0, 0, 1.0))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _symbolIntervalTimer.cancel();
    _symbolVisibilityTimer.cancel();
    _presenter.onEvent(EventID.DISPOSE);
    super.dispose();
  }
}
