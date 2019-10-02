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
  bool _visible;
  int _visibleDuration;
  Timer _symbolVisibilityTimer; //auto-events
  Timer _symbolIntervalTimer;

  SymbolWidgetState() {
    _presenter = new SymbolWidgetPresenter(this);
  }

  @override
  initState() {
    super.initState();
    _visible = false;
  }

  _createHideSymbolTimer(BuildContext context){
    if(_visible){
      if(_symbolVisibilityTimer != null) {
        _symbolVisibilityTimer.cancel();
      }
      _symbolVisibilityTimer = new Timer(
          Duration(milliseconds: _visibleDuration),
              () => _onSymbolHide());
    }
  }
  //when to damage you
  //displaying the lives
  //how to damage you?
  //timer issues

  @override
  onStateUpdate(IState newState) {
    SymbolState newStateSymbol = newState as SymbolState;
    _visible = true;
    _visibleDuration = newStateSymbol.visibilityDuration;
    _symbol = newStateSymbol.symbol;

    print(newStateSymbol.nextSymbolInterval.toString() + "\n");

    if(_symbolIntervalTimer != null) {
      _symbolIntervalTimer.cancel();
    }

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
    _presenter.onEvent(EventID.NEW_SYMBOL);
  }

  _onSymbolHide() {
    if(created) {
      setState(() { _visible = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    created = true;
    //this is a call back to create the timer, which hides the symbol, strictly
    //after the widget is done rendering. This way, we don't screw the player
    //due to slow or inconsistent rendering speeds.
    if(_visible) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _createHideSymbolTimer(context));
    }
    return GestureDetector(
      onTapDown: (TapDownDetails t) {
        _onReact();
      },
      child: Scaffold(
        body: AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 25),
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
